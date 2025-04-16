package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.service.PlaceVolService;
import com.mg.service.VolService;
import com.mg.service.TypeSiegeService;
import com.mg.service.PlaceService;
import com.mg.model.Vol;
import com.mg.model.PlaceVol;
import com.mg.model.TypeSiege;
import com.mg.model.Place;
import java.util.List;

@AnnotationCtrl
public class PlaceVolController {
    private final VolService volService;
    private final TypeSiegeService typeSiegeService;
    private final PlaceVolService placeVolService;
    private final PlaceService placeService;

    public PlaceVolController() {
        this.volService = new VolService();
        this.typeSiegeService = new TypeSiegeService();
        this.placeVolService = new PlaceVolService();
        this.placeService = new PlaceService();
    }

    @GET
    @Url("/admin/vols/places")
    public ModelView listPlacesVol(@Param(name = "volId") int volId) throws Exception {
        ModelView mv = new ModelView("/back-office/vols/places/list.jsp");
        Vol vol = volService.findById(Vol.class, volId, "placeVols");
        mv.addObject("vol", vol);
        mv.addObject("placeVols", vol.getPlaceVols());
        return mv;
    }

    @GET
    @Url("/admin/vols/places/create")
    public ModelView createForm(@Param(name = "volId") int volId) throws Exception {
        ModelView mv = new ModelView("/back-office/vols/places/form.jsp");
        Vol vol = volService.findById(Vol.class, volId);
        // Récupérer les places disponibles pour cet avion
        List<Place> places = placeService.findByAvion(vol.getAvion().getId());
        mv.addObject("vol", vol);
        mv.addObject("places", places);
        return mv;
    }

    @POST
    @Url("/admin/vols/places/create")
    public ModelView createPlaceVol(
            @Param(name = "volId") int volId,
            @Param(name = "placeId") int placeId,
            @Param(name = "prix") double prix) throws Exception {
        Vol vol = volService.findById(Vol.class, volId);
        Place place = placeService.findById(Place.class, placeId);

        PlaceVol placeVol = new PlaceVol();
        placeVol.setVol(vol);
        placeVol.setPlace(place);
        placeVol.setPrix(prix);

        placeVolService.save(placeVol);
        
        ModelView mv = new ModelView();
        mv.setRedirect("/ticket-vol/admin/vols/places?volId=" + volId);
        
        return mv;
    }

    @GET
    @Url("/admin/vols/places/edit")
    public ModelView editForm(
            @Param(name = "id") int id,
            @Param(name = "volId") int volId) throws Exception {
        ModelView mv = new ModelView("/back-office/vols/places/form.jsp");
        Vol vol = volService.findById(Vol.class, volId);
        PlaceVol placeVol = placeVolService.findById(PlaceVol.class, id);
        // Récupérer les places disponibles pour cet avion
        List<Place> places = placeService.findByAvion(vol.getAvion().getId());

        mv.addObject("vol", vol);
        mv.addObject("placeVol", placeVol);
        mv.addObject("places", places);
        return mv;
    }

    @POST
    @Url("/admin/vols/places/edit")
    public ModelView updatePlaceVol(
            @Param(name = "id") int id,
            @Param(name = "volId") int volId,
            @Param(name = "placeId") int placeId,
            @Param(name = "prix") double prix) throws Exception {
        PlaceVol placeVol = placeVolService.findById(PlaceVol.class, id);
        Place place = placeService.findById(Place.class, placeId);

        placeVol.setPlace(place);
        placeVol.setPrix(prix);

        placeVolService.update(placeVol);

        ModelView mv = new ModelView();
        mv.setRedirect("/ticket-vol/admin/vols/places?volId=" + volId);
        
        return mv;
    }

    @POST
    @Url("/admin/vols/places/delete")
    public ModelView deletePlaceVol(
            @Param(name = "id") int id,
            @Param(name = "volId") int volId) throws Exception {
        PlaceVol placeVol = placeVolService.findById(PlaceVol.class, id);
        if (placeVol != null) {
            placeVolService.delete(placeVol);
        }
        ModelView mv = new ModelView();
        mv.setRedirect("/ticket-vol/admin/vols/places?volId=" + volId);
        return mv;
    }
}