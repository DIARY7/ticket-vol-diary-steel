package com.mg.controller;
import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.AuthCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.model.Place;
import com.mg.service.PromotionService;
import com.mg.service.VolService;
import com.mg.service.TypeSiegeService;
import com.mg.model.Promotion;
import com.mg.model.Vol;
import com.mg.model.TypeSiege;
import java.util.List;

@AnnotationCtrl
@AuthCtrl(roles = {"admin"})
public class PromotionController {
    private final PromotionService promotionService;
    private final VolService volService;
    private final TypeSiegeService typeSiegeService;

    public PromotionController() {
        this.promotionService = new PromotionService();
        this.volService = new VolService();
        this.typeSiegeService = new TypeSiegeService();
    }

    @GET
    @Url("/admin/promotions")
    public ModelView listPromotions(@Param(name = "volId") int volId) throws Exception {
        ModelView mv = new ModelView("/back-office/promotions/list.jsp");

        List<Vol> vols = volService.findAll(Vol.class);
        mv.addObject("vols", vols);

        if (volId != 0) {
            Vol selectedVol = volService.findById(Vol.class, volId);
            List<Promotion> promotions = promotionService.findByVol(volId);
            mv.addObject("selectedVol", selectedVol);
            mv.addObject("promotions", promotions);
        } else {
            List<Promotion> promotions = promotionService.findAll(Promotion.class);
            mv.addObject("promotions", promotions);
        }

        return mv;
    }

    @GET
    @Url("/admin/promotions/create")
    public ModelView createForm(@Param(name = "volId") Integer volId) throws Exception {
        ModelView mv = new ModelView("/back-office/promotions/form.jsp");

        List<Vol> vols = volService.findAll(Vol.class);
        List<TypeSiege> typeSieges = typeSiegeService.findAll(TypeSiege.class);

        mv.addObject("vols", vols);
        mv.addObject("typeSieges", typeSieges);

        if (volId != null) {
            Vol selectedVol = volService.findById(Vol.class, volId);
            mv.addObject("selectedVol", selectedVol);
        }

        return mv;
    }

    @POST
    @Url("/admin/promotions/create")
    public ModelView createPromotion(
            @Param(name = "Promotion") Promotion promotion
            ) throws Exception {
        Vol vol = volService.getVolFullById( promotion.getIdVol()   );

        for (Place place : vol.getAvion().getPlaces()){
            if (place.getTypeSiege().getId() == promotion.getIdTypeSiege()){
                if (place.getNombre() < promotion.getNbSiege()){
                    ModelView modelView = new ModelView("/back-office/promotions/form.jsp");

                    modelView.addObject("volId", promotion.getIdVol());
                    modelView.addObject("typeSiegeId", promotion.getIdTypeSiege());
                    modelView.addObject("nbSiege", promotion.getNbSiege());
                    modelView.addObject("pourcentageReduction", promotion.getPourcentageReduction());
                    modelView.addObject("error", "Le nombre de siège doit être inférieur ou égale à " + place.getNombre());
                    List<Vol> vols = volService.findAll(Vol.class);
                    List<TypeSiege> typeSieges = typeSiegeService.findAll(TypeSiege.class);

                    modelView.addObject("vols", vols);
                    modelView.addObject("typeSieges", typeSieges);

                    return modelView;
                }
            }
        }
        promotionService.createPromotion(promotion.getIdVol(), promotion.getIdTypeSiege(), promotion.getNbSiege(), promotion.getPourcentageReduction());
        ModelView modelView = new ModelView();
        modelView.setRedirect("/ticket-vol/admin/promotions?volId=" + promotion.getIdVol());
        return modelView;
    }

    @POST
    @Url("/admin/promotions/delete")
    public ModelView deletePromotion(
            @Param(name = "id") Integer id,
            @Param(name = "volId") Long volId) throws Exception {

        Promotion promotion = promotionService.findById(Promotion.class, id);
        if (promotion != null) {
            promotionService.delete(promotion);
        }
        ModelView modelView = new ModelView();
        modelView.setRedirect("/ticket-vol/admin/promotions" + (volId != null ? "?volId=" + volId : ""));
        
        return modelView;
    }
}