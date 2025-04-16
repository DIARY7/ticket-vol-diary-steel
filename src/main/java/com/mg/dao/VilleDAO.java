package com.mg.dao;

import com.mg.model.Ville;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class VilleDAO extends BaseDao<Ville> {

    public VilleDAO() {
        super(Ville.class);
    }

    public List<Ville> findByNom(String nom) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Ville v WHERE LOWER(v.nom) LIKE LOWER(:nom)";
            Query<Ville> query = session.createQuery(hql, Ville.class);
            query.setParameter("nom", "%" + nom + "%");
            return query.list();
        }
    }

    public List<Ville> findVillesDepartWithVols() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT v.villeDepart FROM Vol v " +
                    "WHERE v.dateDepart > CURRENT_TIMESTAMP " +
                    "ORDER BY v.villeDepart.nom";
            Query<Ville> query = session.createQuery(hql, Ville.class);
            return query.list();
        }
    }

    public List<Ville> findVillesArriveePourVilleDepart(Integer villeDepartId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT v.villeArrive FROM Vol v " +
                    "WHERE v.villeDepart.id = :villeDepartId " +
                    "AND v.dateDepart > CURRENT_TIMESTAMP " +
                    "ORDER BY v.villeArrive.nom";
            Query<Ville> query = session.createQuery(hql, Ville.class);
            query.setParameter("villeDepartId", villeDepartId);
            return query.list();
        }
    }

}