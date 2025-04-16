package com.mg.dao;

import com.mg.model.Parametre;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class ParametreDAO extends BaseDao<Parametre> {

    public ParametreDAO() {
        super(Parametre.class);
    }

    public Parametre findById(Class<Parametre> type, Object id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(type, (String) id);
        }
    }

    public Parametre findFirst() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Parametre> query = session.createQuery("FROM Parametre", Parametre.class);
            query.setMaxResults(1);
            return query.uniqueResult();
        }
    }
}