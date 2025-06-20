package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.AuthCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.RestApi;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.CustomSession;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.DTO.VolDTO;
import com.mg.model.*;
import com.mg.service.ReservationService;
import com.mg.service.VolService;
import com.mg.utils.ConfigLoader;

import jakarta.servlet.http.HttpServletResponse;

import com.mg.service.ParametreService;
import com.mg.service.PlaceService;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;


@AnnotationCtrl
@AuthCtrl (roles = {"client"})
public class ReservationController {
    private final ReservationService reservationService;
    private final VolService volService;
    private final ParametreService parametreService;
    private final PlaceService placeService;

    public ReservationController() {
        this.reservationService = new ReservationService();
        this.volService = new VolService();
        this.parametreService = new ParametreService();
        this.placeService = new PlaceService();
    }

    @GET
    @Url("/reserver")
    public ModelView reservationForm(@Param(name = "volId") int volId) throws Exception {
        ModelView mv = new ModelView("/front-office/reservations/form.jsp");
        Vol vol = volService.findById(Vol.class, volId, "placeVols");
        if (vol != null && reservationService.isReservationAllowed(vol)) {
            mv.addObject("vol", vol);
        } else {
            mv.addObject("error", "La réservation n'est plus possible pour ce vol");
        }
        return mv;
    }

    @POST
    @Url("/vols/reserver")
    public ModelView createReservation(
            @Param(name = "volId") int volId,
            @Param(name = "typeSiegeId") int typeSiegeId,
            @Param(name = "nombreAdultes") int nombreAdultes,
            @Param(name = "nombreEnfants") int nombreEnfants,
            CustomSession session) throws Exception {
        ModelView modelView = new ModelView();
        Vol vol = volService.getVolFullById(volId);

        if (vol != null) {
            Utilisateur utilisateur = (Utilisateur) session.get("user");
            Double prixInitial = 0.0;
            int nombrePlacesTotal = nombreAdultes + nombreEnfants;
            VolDTO volDTO = volService.getVolsDTOById(vol);
            Integer placeVolId = null;

            for (PlaceVol placeVol : vol.getPlaceVols()) {
                // Utiliser la nouvelle structure pour accéder au type de siège via l'objet Place
                if (placeVol.getPlace().getTypeSiege().getId().equals(typeSiegeId)) {
                    // Obtenir la désignation du type de siège via la nouvelle structure
                    String designation = placeVol.getPlace().getTypeSiege().getDesignation();
                    if (volDTO.getPlacesDisponibles().get(designation) < nombrePlacesTotal) {
                        modelView
                                .setUrl("/ticket-vol/reserver?volId=" + volId + "&error=Nombre de places insuffisant");
                        return modelView;
                    }
                    prixInitial = placeVol.getPrix();
                    placeVolId = placeVol.getId();
                    break;
                }
            }

            if (placeVolId == null) {
                modelView.setRedirect("/ticket-vol/reserver?volId=" + volId + "&error=Type de siège non trouvé");
                return modelView;
            }

            Parametre reductionEnfant = parametreService.findById(Parametre.class, "reduc_enfant");
            double tauxReductionEnfant = reductionEnfant != null ? reductionEnfant.getValeur() : 0.0;

            Double prixAdultes = volService.promotionAvailable(vol, typeSiegeId, nombreAdultes, prixInitial);

            // Prix enfants (avec réduction enfant)
            Double prixEnfants = volService.promotionAvailable(vol, typeSiegeId, nombreEnfants, prixInitial);
            prixEnfants = prixEnfants * (1 - tauxReductionEnfant / 100);

            Double prixTotal = prixAdultes + prixEnfants;

            // Création de la réservation
            reservationService.createReservation(placeVolId, utilisateur.getId(), typeSiegeId, nombrePlacesTotal,
                    prixTotal, nombreAdultes, nombreEnfants);
            modelView.setRedirect("/ticket-vol/mes-reservations");
            return modelView;
        }
        modelView.setRedirect("/ticket-vol/reserver?volId=" + volId + "&error=Vol inconnu");
        return modelView;
    }

    @GET
    @Url("/mes-reservations")
    public ModelView listUserReservations(CustomSession session) throws Exception {
        ModelView mv = new ModelView("/front-office/reservations/list.jsp");
        Utilisateur utilisateur = (Utilisateur) session.get("user");

        List<Reservation> reservations = reservationService.findByUtilisateur(utilisateur.getId());
        String serverIp = ConfigLoader.getServerIp("server.properties"); 

        mv.addObject("reservations", reservations);
        mv.addObject("serverIp", serverIp);

        return mv;
    }

    @GET
    @Url("/annuler-reservation")
    public ModelView annulationReservation(@Param(name = "idReservation") int idReservation,
            CustomSession customSession) throws Exception {
        ModelView modelView = new ModelView();
        Utilisateur utilisateur = (Utilisateur) customSession.get("user");
        Boolean process = false;
        if (utilisateur != null) {
            process = reservationService.cancelReservation(idReservation);
        }
        if (process) {
            modelView.setRedirect("/ticket-vol/mes-reservations");
            return modelView;
        }
        modelView.setRedirect("/ticket-vol/mes-reservations?error=Erreur lors de l'annulation de la réservation");
        return modelView;
    }

    @GET
    @Url("/reservation-pdf")
    public void exportToPdf(int idReservation) {
        String serverIp = ConfigLoader.getServerIp("server.properties");
        if (serverIp == null) {
            System.err.println("Impossible de charger l'adresse IP du serveur.");
            return;
        }

        String url = serverIp + "/api/reservations/" + idReservation + "/pdf";

        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        try {
            HttpResponse<byte[]> response = client.send(request, HttpResponse.BodyHandlers.ofByteArray());

            if (response.statusCode() == 200) {
                byte[] pdfData = response.body();
                try (FileOutputStream fos = new FileOutputStream("reservation-" + idReservation + ".pdf")) {
                    fos.write(pdfData);
                }

            } else {
                System.err.println("Erreur HTTP : " + response.statusCode());
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    // @GET
    // @RestApi
    // @Url("/reservations-csv")
    // public void exportToCSV(HttpServletResponse response,int idUser) {
    //     try {
    //         reservationService.exportReservationsToCSV(response,idUser);
    //     } catch (IOException e) {
    //         throw new RuntimeException("Erreur lors de l'export CSV", e);
    //     }
    // }
}