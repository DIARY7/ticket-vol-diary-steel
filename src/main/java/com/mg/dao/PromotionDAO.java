package com.mg.dao;

import com.mg.model.Promotion;
import com.mg.model.TypeSiege;
import com.mg.model.Vol;
import com.mg.service.TransactionService;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class PromotionDAO extends BaseDao<Promotion> {

    public PromotionDAO() {
        super(Promotion.class);
    }

    public List<Promotion> findByVol(Integer volId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Promotion p WHERE p.vol.id = :volId";
            Query<Promotion> query = session.createQuery(hql, Promotion.class);
            query.setParameter("volId", volId);
            return query.list();
        }
    }

    public List<Promotion> findByVolAndTypeSiege(Vol vol, TypeSiege typeSiege) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Promotion p WHERE p.vol = :vol AND p.typeSiege = :typeSiege";
            Query<Promotion> query = session.createQuery(hql, Promotion.class);
            query.setParameter("vol", vol);
            query.setParameter("typeSiege", typeSiege);
            return query.list();
        }
    }

    public List<Promotion> findActivePromotions(Long volId, Long typeSiegeId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Promotion p WHERE p.vol.id = :volId " +
                    "AND p.typeSiege.id = :typeSiegeId " +
                    "AND p.nbSiege > 0";
            Query<Promotion> query = session.createQuery(hql, Promotion.class);
            query.setParameter("volId", volId);
            query.setParameter("typeSiegeId", typeSiegeId);
            return query.list();
        }
    }

    public void updateNbSiege(Long promotionId, Integer nbSiege) {
        TransactionService.executeInTransactionWithoutResult(session -> {
            String hql = "UPDATE Promotion p SET p.nbSiege = :nbSiege WHERE p.id = :id";
            Query query = session.createQuery(hql);
            query.setParameter("nbSiege", nbSiege);
            query.setParameter("id", promotionId);
            query.executeUpdate();
            return null;
        });
    }

    public Integer getTotalPromotionalSeats(Vol vol, TypeSiege typeSiege) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT SUM(p.nbSiege) FROM Promotion p " +
                    "WHERE p.vol = :vol AND p.typeSiege = :typeSiege";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("vol", vol);
            query.setParameter("typeSiege", typeSiege);
            Long result = query.uniqueResult();
            return result != null ? result.intValue() : 0;
        }
    }
}