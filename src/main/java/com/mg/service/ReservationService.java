package com.mg.service;

import com.mg.dao.*;
import com.mg.model.*;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ReservationService extends AbstractService<Reservation> {
    private final ReservationDAO reservationDAO;
    private final UtilisateurDAO utilisateurDAO;
    private final PlaceVolDAO placeVolDAO;

    public ReservationService() {
        super(new ReservationDAO());
        this.reservationDAO = new ReservationDAO();
        this.utilisateurDAO = new UtilisateurDAO();
        this.placeVolDAO = new PlaceVolDAO();
    }

    public List<Reservation> findByVol(Integer volId) {
        return reservationDAO.findByVol(volId);
    }

    public List<Reservation> findByUtilisateur(Integer userId) {
        return reservationDAO.findByUtilisateur(userId);
    }

    public boolean isReservationAllowed(Vol vol) {
        return reservationDAO.isReservationAllowed(vol);
    }

    public Reservation createReservation(Integer placeVolId, Integer utilisateurId,
            Integer typeSiegeId, Integer nombrePlacesTotal, Double prix, Integer nombreAdultes, Integer nombreEnfants) {
        Reservation reservation = new Reservation();
        reservation.setPlaceVol(placeVolDAO.findById(PlaceVol.class, placeVolId));
        reservation.setUtilisateur(utilisateurDAO.findById(Utilisateur.class, utilisateurId));
        reservation.setNombrePlaces(nombrePlacesTotal);
        reservation.setNombreAdultes(nombreAdultes);
        reservation.setNombreEnfants(nombreEnfants);
        reservation.setPrix(prix);
        reservation.setValider(true);

        reservationDAO.save(reservation);
        return reservation;
    }

    public Boolean cancelReservation(Integer reservationId) {
        return reservationDAO.cancelReservation(reservationId);
    }

    public List<Reservation> findRecentReservations() {
        return reservationDAO.findRecentReservations();
    }

    public long countActiveReservations() {
        return reservationDAO.countActiveReservations();
    }

    public void exportReservationsToCSV(HttpServletResponse response,Integer idReservation) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"reservations.csv\"");

        List<Reservation> reservations = reservationDAO.findByUtilisateur(idReservation);

        try (PrintWriter writer = response.getWriter()) {
            writer.println("Reservation ID,Prix,Validée,Nb Places,Nb Adultes,Nb Enfants,"
                    + "Utilisateur ID,Nom,Prenom,Pseudo,Role,"
                    + "PlaceVol ID,PlaceVol Info");

            // Écrire les données
            for (Reservation r : reservations) {
                String utilisateurInfo = r.getUtilisateur() != null ?
                        String.format("%d,%s,%s,%s,%s",
                                r.getUtilisateur().getId(),
                                escape(r.getUtilisateur().getNom()),
                                escape(r.getUtilisateur().getPrenom()),
                                escape(r.getUtilisateur().getPseudo()),
                                escape(r.getUtilisateur().getRole())) :
                        ",,,,";

                String placeVolInfo = r.getPlaceVol() != null ?
                        String.format("%d,%s",
                                r.getPlaceVol().getId(),
                                escape(r.getPlaceVol().getPlace().getTypeSiege().getDesignation().toString())) : ",";

                writer.printf("%d,%.2f,%b,%d,%d,%d,%s,%s%n",
                        r.getId(),
                        r.getPrix(),
                        r.getValider(),
                        r.getNombrePlaces(),
                        r.getNombreAdultes(),
                        r.getNombreEnfants(),
                        utilisateurInfo,
                        placeVolInfo
                );
            }
        }
    }

    private String escape(String field) {
        if (field == null) return "";
        if (field.contains(",") || field.contains("\"") || field.contains("\n")) {
            return "\"" + field.replace("\"", "\"\"") + "\"";
        }
        return field;
    }
}