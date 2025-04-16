package com.mg.service;

import com.mg.dao.PromotionDAO;
import com.mg.dao.VolDAO;
import com.mg.dao.TypeSiegeDAO;
import com.mg.model.Promotion;
import com.mg.model.Vol;
import com.mg.model.TypeSiege;
import java.util.List;

public class PromotionService extends AbstractService<Promotion> {
    private final PromotionDAO promotionDAO;
    private final VolDAO volDAO;
    private final TypeSiegeDAO typeSiegeDAO;

    public PromotionService() {
        super(new PromotionDAO());
        this.promotionDAO = (PromotionDAO) dao;
        this.volDAO = new VolDAO();
        this.typeSiegeDAO = new TypeSiegeDAO();
    }

    public List<Promotion> findByVol(Integer volId) {
        return promotionDAO.findByVol(volId);
    }

    public List<Promotion> findByVolAndTypeSiege(Vol vol, TypeSiege typeSiege) {
        return promotionDAO.findByVolAndTypeSiege(vol, typeSiege);
    }

    public Promotion createPromotion(Integer volId, Integer typeSiegeId, Integer nbSiege, Double reduction) {
        Promotion promotion = new Promotion();
        promotion.setVol(volDAO.findById(Vol.class, volId));
        promotion.setTypeSiege(typeSiegeDAO.findById(TypeSiege.class, typeSiegeId));
        promotion.setNbSiege(nbSiege);
        promotion.setPourcentageReduction(reduction);

        promotionDAO.save(promotion);
        return promotion;
    }

    public void updateNbSiege(Integer promotionId, Integer nbSiege) {
        Promotion promotion = promotionDAO.findById(Promotion.class, promotionId);
        if (promotion != null) {
            promotion.setNbSiege(nbSiege);
            promotionDAO.update(promotion);
        }
    }
}