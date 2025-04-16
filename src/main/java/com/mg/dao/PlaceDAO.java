package com.mg.dao;

import com.mg.model.Place;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class PlaceDAO extends BaseDao<Place> {

    public PlaceDAO() {
        super(Place.class);
    }

    public List<Place> findByAvion(Integer avionId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Place p WHERE p.avion.id = :avionId";
            Query<Place> query = session.createQuery(hql, Place.class);
            query.setParameter("avionId", avionId);
            return query.list();
        }
    }

    public List<Place> findByAvionAndTypeSiege(Integer avionId, Integer typeSiegeId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Place p WHERE p.avion.id = :avionId AND p.typeSiege.id = :typeSiegeId";
            Query<Place> query = session.createQuery(hql, Place.class);
            query.setParameter("avionId", avionId);
            query.setParameter("typeSiegeId", typeSiegeId);
            return query.list();
        }
    }
}