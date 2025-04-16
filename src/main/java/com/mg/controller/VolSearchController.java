package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.AuthCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.model.Ville;
import com.mg.model.Vol;
import com.mg.service.VilleService;
import com.mg.service.VolService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@AnnotationCtrl
@AuthCtrl(roles = {"client"})
public class VolSearchController {
    private final VolService volService = new VolService();
    private final VilleService villeService = new VilleService();
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @GET
    @Url("/vols/search")
    public ModelView searchForm() throws Exception {
        ModelView mv = new ModelView("/front-office/vols/list.jsp");
        List<Ville> villes = villeService.findAll(Ville.class);
        List<Vol> vols = volService.getVolValide();
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        return mv;
    }


    @POST
    @Url("/vols/search")
    public ModelView searchVols(
            @Param(name = "villeDepart") int villeDepartId,
            @Param(name = "villeArrive") int villeArriveId,
            @Param(name = "dateDepart") String dateDepartStr,
            @Param(name = "maxPrice") double maxPrice) throws Exception {

        ModelView mv = new ModelView("/front-office/vols/list.jsp");

        Ville villeDepart = villeDepartId != 0 ? villeService.findById(villeDepartId) : null;
        Ville villeArrive = villeArriveId != 0 ? villeService.findById(villeArriveId) : null;
        Date dateDepart = dateDepartStr != null && !dateDepartStr.isEmpty() ? dateFormat.parse(dateDepartStr) : null;

        List<Vol> vols = volService.searchVols(villeDepart, villeArrive, dateDepart, maxPrice);
        mv.addObject("vols", vols);
        mv.addObject("dateDepart", dateDepartStr);

        // Garder les critères de recherche pour le formulaire
        List<Ville> villes = villeService.findAll(Ville.class);
        mv.addObject("villes", villes);
        mv.addObject("villeDepartId", villeDepartId);
        mv.addObject("villeArriveId", villeArriveId);
        mv.addObject("maxPrice", maxPrice);

        return mv;
    }
}