package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.service.ParametreService;

@AnnotationCtrl
public class ParametreController {
    private final ParametreService parametreService;

    public ParametreController() {
        this.parametreService = new ParametreService();
    }

    @GET
    @Url("/admin/parametres")
    public ModelView parametresForm() throws Exception {
        ModelView mv = new ModelView("/back-office/parametres/form.jsp");

        Double delaiReservation = parametreService.getValeurParametre("delai_reservation", 24.0);
        Double delaiAnnulation = parametreService.getValeurParametre("delai_annulation", 48.0);
        Double reductionEnfant = parametreService.getValeurParametre("reduc_enfant", 20.0);

        mv.addObject("delaiReservation", delaiReservation);
        mv.addObject("delaiAnnulation", delaiAnnulation);
        mv.addObject("reductionEnfant", reductionEnfant);

        return mv;
    }

    @POST
    @Url("/admin/parametres/update")
    public ModelView updateParametres(
            @Param(name = "delaiReservation") double delaiReservation,
            @Param(name = "delaiAnnulation") double delaiAnnulation,
            @Param(name = "reductionEnfant") double reductionEnfant) throws Exception {

        parametreService.updateDelais(delaiReservation, delaiAnnulation);
        parametreService.updateReductionEnfant(reductionEnfant);

        ModelView modelView = new ModelView();
        modelView.setRedirect("/ticket-vol/admin/parametres");
        return modelView;
    }
}