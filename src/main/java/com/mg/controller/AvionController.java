package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.service.AvionService;
import com.mg.service.TypeSiegeService;
import com.mg.model.Avion;
import com.mg.model.Place;
import com.mg.model.TypeSiege;
import java.text.SimpleDateFormat;
import java.util.List;

@AnnotationCtrl
public class AvionController {
    private final AvionService avionService;
    private final TypeSiegeService typeSiegeService;
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public AvionController() {
        this.avionService = new AvionService();
        this.typeSiegeService = new TypeSiegeService();
    }

    @GET
    @Url("/admin/avions")
    public ModelView listAvions() throws Exception {
        ModelView mv = new ModelView("/back-office/avions/list.jsp");
        List<Avion> avions = avionService.findAll(Avion.class);
        mv.addObject("avions", avions);
        return mv;
    }

    @GET
    @Url("/admin/avions/create")
    public ModelView createForm() throws Exception {
        ModelView mv = new ModelView("/back-office/avions/form.jsp");
        List<TypeSiege> typeSieges = typeSiegeService.findAll(TypeSiege.class);
        mv.addObject("typeSieges", typeSieges);
        return mv;
    }

    @POST
    @Url("/admin/avions/create")
    public ModelView createAvion(
            @Param(name = "modele") String modele,
            @Param(name = "dateFabrication") String dateFabrication,
            @Param(name = "typeSieges") int[] typeSiegeIds,
            @Param(name = "nombrePlaces") int[] nombrePlaces) throws Exception {

        avionService.createAvion(modele, dateFormat.parse(dateFabrication), typeSiegeIds, nombrePlaces);
        return new ModelView("redirect:/admin/avions");
    }

    @GET
    @Url("/admin/avions/edit")
    public ModelView editForm(@Param(name = "id") int id) throws Exception {
        ModelView mv = new ModelView("/back-office/avions/form.jsp");
        Avion avion = avionService.findById(Avion.class, id);
        List<TypeSiege> typeSieges = typeSiegeService.findAll(TypeSiege.class);
        List<Place> places = avion.getPlaces();

        mv.addObject("avion", avion);
        mv.addObject("typeSieges", typeSieges);
        mv.addObject("places", places);
        return mv;
    }

    @POST
    @Url("/admin/avions/edit")
    public ModelView updateAvion(
            @Param(name = "id") int id,
            @Param(name = "modele") String modele,
            @Param(name = "dateFabrication") String dateFabrication,
            @Param(name = "typeSieges") int[] typeSiegeIds,
            @Param(name = "nombrePlaces") int[] nombrePlaces) throws Exception {

        avionService.updateAvion(id, modele, dateFormat.parse(dateFabrication), typeSiegeIds, nombrePlaces);
        return new ModelView("redirect:/admin/avions");
    }

    @POST
    @Url("/admin/avions/delete")
    public ModelView deleteAvion(@Param(name = "id") Integer id) throws Exception {
        avionService.deleteAvion(id);
        return new ModelView("redirect:/admin/avions");
    }
}