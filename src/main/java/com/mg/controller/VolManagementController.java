package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.service.VolService;
import com.mg.service.VilleService;
import com.mg.service.AvionService;
import com.mg.model.Vol;
import com.mg.model.Ville;
import com.mg.model.Avion;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Date;

@AnnotationCtrl
public class VolManagementController {
    private final VolService volService;
    private final VilleService villeService;
    private final AvionService avionService;
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    public VolManagementController() {
        this.volService = new VolService();
        this.villeService = new VilleService();
        this.avionService = new AvionService();
    }

    @GET
    @Url("/admin/vols")
    public ModelView listVols(
            @Param(name = "villeDepartId") int villeDepartId,
            @Param(name = "villeArriveId") int villeArriveId,
            @Param(name = "dateDebut") String dateDebut,
            @Param(name = "dateFin") String dateFin,
            @Param(name = "prixMin") double prixMin,
            @Param(name = "prixMax") double prixMax) throws Exception {

        ModelView mv = new ModelView("/back-office/vols/list.jsp");

        List<Ville> villes = villeService.findAll(Ville.class);
        mv.addObject("villes", villes);

        Date dateDebutObj = dateDebut != null ? dateFormat.parse(dateDebut) : null;
        Date dateFinObj = dateFin != null ? dateFormat.parse(dateFin) : null;

        List<Vol> vols;
        if (villeDepartId != 0 || villeArriveId != 0 || dateDebut != null ||
                dateFin != null || prixMin != 0 || prixMax != 0) {
            Ville villeDepart = villeDepartId != 0 ? villeService.findById(Ville.class, villeDepartId) : null;
            Ville villeArrive = villeArriveId != 0 ? villeService.findById(Ville.class, villeArriveId) : null;
            vols = volService.searchVolsAdvanced(villeDepart, villeArrive, dateDebutObj, dateFinObj, prixMin, prixMax);
        } else {
            vols = volService.findAll(Vol.class,"placeVols");
        }

        mv.addObject("vols", vols);
        mv.addObject("villeDepartId", villeDepartId);
        mv.addObject("villeArriveId", villeArriveId);
        mv.addObject("dateDebut", dateDebut);
        mv.addObject("dateFin", dateFin);
        mv.addObject("prixMin", prixMin);
        mv.addObject("prixMax", prixMax);

        return mv;
    }

    @GET
    @Url("/admin/vols/create")
    public ModelView createForm() throws Exception {
        ModelView mv = new ModelView("/back-office/vols/form.jsp");
        List<Ville> villes = villeService.findAll(Ville.class);
        List<Avion> avions = avionService.findAll(Avion.class);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        return mv;
    }

    @POST
    @Url("/admin/vols/create")
    public ModelView createVol(
            @Param(name = "villeDepartId") int villeDepartId,
            @Param(name = "villeArriveId") int villeArriveId,
            @Param(name = "avionId") int avionId,
            @Param(name = "dateDepart") String dateDepart) throws Exception {
        
        System.out.println("\nLa ville departId dans Create Vol est "+villeDepartId);
        System.out.println("\nLa ville arrivé Id  dans Create Vol est "+villeArriveId);

        volService.createVol(villeDepartId, villeArriveId, avionId, dateFormat.parse(dateDepart));
        ModelView mv = new ModelView();
        mv.setRedirect("/ticket-vol/admin/vols");

        return mv;
    }

    @GET
    @Url("/admin/vols/edit")
    public ModelView editForm(@Param(name = "id") int id) throws Exception {
        ModelView mv = new ModelView("/back-office/vols/form.jsp");
        Vol vol = volService.findById(Vol.class, id);
        List<Ville> villes = villeService.findAll(Ville.class);
        List<Avion> avions = avionService.findAll(Avion.class);

        mv.addObject("vol", vol);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        return mv;
    }

    @POST
    @Url("/admin/vols/edit")
    public ModelView updateVol(
            @Param(name = "id") int id,
            @Param(name = "villeDepartId") int villeDepartId,
            @Param(name = "villeArriveId") int villeArriveId,
            @Param(name = "avionId") int avionId,
            @Param(name = "dateDepart") String dateDepart) throws Exception {

        volService.updateVol(id, villeDepartId, villeArriveId, avionId, dateFormat.parse(dateDepart));
        ModelView mv = new ModelView();
        mv.setRedirect("/ticket-vol/admin/vols");
        return mv;
    }

    @POST
    @Url("/admin/vols/delete")
    public ModelView deleteVol(@Param(name = "id") Integer id) throws Exception {
        Vol vol = volService.findById(Vol.class, id);
        if (vol != null) {
            volService.delete(vol);
        }
        ModelView mv = new ModelView();
        mv.setRedirect("/ticket-vol/admin/vols");
        return mv;
    }
}