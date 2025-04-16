package com.mg.dao;

import com.mg.model.TypeSiege;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class TypeSiegeDAO extends BaseDao<TypeSiege> {

    public TypeSiegeDAO() {
        super(TypeSiege.class);
    }


    public List<TypeSiege> findAvailableForVol(Integer volId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT ts FROM TypeSiege ts " +
                    "INNER JOIN Place p ON p.typeSiege = ts " +
                    "INNER JOIN Vol v ON p.avion = v.avion " +
                    "WHERE v.id = :volId";
            Query<TypeSiege> query = session.createQuery(hql, TypeSiege.class);
            query.setParameter("volId", volId);
            return query.list();
        }
    }

    public List<TypeSiege> findWithAvailablePromotions(Integer volId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT ts FROM TypeSiege ts " +
                    "INNER JOIN Promotion p ON p.typeSiege = ts " +
                    "WHERE p.vol.id = :volId AND p.nbSiege > 0";
            Query<TypeSiege> query = session.createQuery(hql, TypeSiege.class);
            query.setParameter("volId", volId);
            return query.list();
        }
    }
}