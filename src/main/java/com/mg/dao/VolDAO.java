package com.mg.dao;

import com.mg.model.PlaceVol;
import com.mg.model.Vol;
import com.mg.model.Ville;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.persistence.EntityGraph;
import javax.persistence.Subgraph;
import java.util.*;

public class VolDAO extends BaseDao<Vol> {

    public VolDAO() {
        super(Vol.class);
    }

    public List<Vol> searchVols(Ville villeDepart, Ville villeArrive, Date dateDepart, Double maxPrice) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("SELECT DISTINCT v FROM Vol v LEFT JOIN FETCH v.placeVols WHERE 1=1");
            if (villeDepart != null) {
                hql.append(" AND v.villeDepart = :villeDepart");
            }
            if (villeArrive != null) {
                hql.append(" AND v.villeArrive = :villeArrive");
            }
            if (dateDepart != null) {
                hql.append(" AND DATE(v.dateDepart) = DATE(:dateDepart)");
            }
            // if (maxPrice != null) {
            //     hql.append(" AND v.prix <= :maxPrice");
            // }

            Query<Vol> query = session.createQuery(hql.toString(), Vol.class);

            if (villeDepart != null) {
                query.setParameter("villeDepart", villeDepart);
            }
            if (villeArrive != null) {
                query.setParameter("villeArrive", villeArrive);
            }
            if (dateDepart != null) {
                query.setParameter("dateDepart", dateDepart);
            }
            // if (maxPrice != null) {
            //     query.setParameter("maxPrice", maxPrice);
            // }

            return query.list();
        }
    }

    public List<Vol> searchVolsAdvanced(Ville villeDepart, Ville villeArrive,
                                        Date dateDebut, Date dateFin, Double prixMin, Double prixMax) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Vol v LEFT JOIN FETCH v.placeVols WHERE 1=1");

            if (villeDepart != null) {
                hql.append(" AND v.villeDepart = :villeDepart");
            }
            if (villeArrive != null) {
                hql.append(" AND v.villeArrive = :villeArrive");
            }
            if (dateDebut != null && dateFin != null) {
                hql.append(" AND v.dateDepart BETWEEN :dateDebut AND :dateFin");
            } else if (dateDebut != null) {
                hql.append(" AND v.dateDepart >= :dateDebut");
            } else if (dateFin != null) {
                hql.append(" AND v.dateDepart <= :dateFin");
            }
            if (prixMin != null) {
                hql.append(" AND v.prix >= :prixMin");
            }
            if (prixMax != null) {
                hql.append(" AND v.prix <= :prixMax");
            }

            hql.append(" ORDER BY v.dateDepart");

            Query<Vol> query = session.createQuery(hql.toString(), Vol.class);

            if (villeDepart != null) {
                query.setParameter("villeDepart", villeDepart);
            }
            if (villeArrive != null) {
                query.setParameter("villeArrive", villeArrive);
            }
            if (dateDebut != null) {
                query.setParameter("dateDebut", dateDebut);
            }
            if (dateFin != null) {
                query.setParameter("dateFin", dateFin);
            }
            if (prixMin != null) {
                query.setParameter("prixMin", prixMin);
            }
            if (prixMax != null) {
                query.setParameter("prixMax", prixMax);
            }

            return query.list();
        }
    }

    public List<Vol> getAvailableVols(Date fromDate, Date toDate) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Vol v WHERE v.dateDepart BETWEEN :fromDate AND :toDate " +
                    "AND v.dateDepart > CURRENT_TIMESTAMP ORDER BY v.dateDepart";
            Query<Vol> query = session.createQuery(hql, Vol.class);
            query.setParameter("fromDate", fromDate);
            query.setParameter("toDate", toDate);
            return query.list();
        }
    }

    public List<Vol> searchVols(Integer villeDepartId, Integer villeArriveId, Date dateDebut, Date dateFin, Double prixMin, Double prixMax) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Vol v WHERE 1=1");
            List<String> conditions = new ArrayList<>();

            if (villeDepartId != null) {
                conditions.add("v.villeDepart.id = :villeDepartId");
            }
            if (villeArriveId != null) {
                conditions.add("v.villeArrive.id = :villeArriveId");
            }
            if (dateDebut != null) {
                conditions.add("v.dateDepart >= :dateDebut");
            }
            if (dateFin != null) {
                conditions.add("v.dateDepart <= :dateFin");
            }
            if (prixMin != null) {
                conditions.add("v.prix >= :prixMin");
            }
            if (prixMax != null) {
                conditions.add("v.prix <= :prixMax");
            }

            if (!conditions.isEmpty()) {
                hql.append(" AND ").append(String.join(" AND ", conditions));
            }

            hql.append(" ORDER BY v.dateDepart");

            Query<Vol> query = session.createQuery(hql.toString(), Vol.class);

            if (villeDepartId != null) {
                query.setParameter("villeDepartId", villeDepartId);
            }
            if (villeArriveId != null) {
                query.setParameter("villeArriveId", villeArriveId);
            }
            if (dateDebut != null) {
                query.setParameter("dateDebut", dateDebut);
            }
            if (dateFin != null) {
                query.setParameter("dateFin", dateFin);
            }
            if (prixMin != null) {
                query.setParameter("prixMin", prixMin);
            }
            if (prixMax != null) {
                query.setParameter("prixMax", prixMax);
            }

            return query.list();
        }
    }

    public List<Vol> findVolsDisponibles(Integer villeDepartId, Integer villeArriveId, Date dateDepart) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Vol v WHERE v.villeDepart.id = :villeDepartId " +
                    "AND v.villeArrive.id = :villeArriveId " +
                    "AND DATE(v.dateDepart) = DATE(:dateDepart) " +
                    "AND v.dateDepart > CURRENT_TIMESTAMP " +
                    "ORDER BY v.dateDepart";

            Query<Vol> query = session.createQuery(hql, Vol.class);
            query.setParameter("villeDepartId", villeDepartId);
            query.setParameter("villeArriveId", villeArriveId);
            query.setParameter("dateDepart", dateDepart);

            return query.list();
        }
    }

    public List<Vol> findUpcomingFlights() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT v FROM Vol v " +
                    "LEFT JOIN FETCH v.placeVols " +
                    "WHERE v.dateDepart > CURRENT_TIMESTAMP " +
                    "ORDER BY v.dateDepart ASC";
            Query<Vol> query = session.createQuery(hql, Vol.class);
            List<Vol> vols = query.list();

            if (!vols.isEmpty()) {
                String placeVolHql = "SELECT DISTINCT v FROM Vol v " +
                        "LEFT JOIN FETCH v.placeVols " +
                        "WHERE v IN :vols";
                Query<Vol> placeVolQuery = session.createQuery(placeVolHql, Vol.class);
                placeVolQuery.setParameter("vols", vols);
                vols = placeVolQuery.list();
            }
            return vols;
        }
    }

    public List<Vol> findFullAttributeVols() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            EntityGraph<Vol> graph = session.createEntityGraph(Vol.class);
            graph.addAttributeNodes("placeVols");
            Subgraph<PlaceVol> placeVolSubgraph = graph.addSubgraph("placeVols");
            placeVolSubgraph.addAttributeNodes("reservations");

            String hql = "SELECT DISTINCT v FROM Vol v "
                    + "WHERE v.dateDepart > CURRENT_TIMESTAMP "
                    + "ORDER BY v.dateDepart ASC";

            return session.createQuery(hql, Vol.class)
                    .setHint("javax.persistence.fetchgraph", graph)
                    .getResultList();
        }
    }

    public Vol findFullAttributVol(Integer id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            EntityGraph<Vol> graph = session.createEntityGraph(Vol.class);
            graph.addAttributeNodes("placeVols", "promotions");
            Subgraph<PlaceVol> placeVolSubgraph = graph.addSubgraph("placeVols");
            placeVolSubgraph.addAttributeNodes("promotions");

            Map<String, Object> properties = new HashMap<>();
            properties.put("javax.persistence.fetchgraph", graph);

            return session.find(Vol.class, id, properties);
        }
    }

    public Vol findUpcomingFlightsById(Integer id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Étape 1 : Charger Vol avec placeVols
            String hql = "SELECT DISTINCT v FROM Vol v " +
                    "LEFT JOIN FETCH v.placeVols pv " + // Charger placeVols
                    "WHERE v.id = :id " +
                    "ORDER BY v.dateDepart ASC";
            Query<Vol> query = session.createQuery(hql, Vol.class);
            query.setParameter("id", id);
            Vol vol = query.getSingleResult();

            if (vol != null) {
                // Étape 2 : Charger les reservations pour chaque placeVol
                String reservationsHql = "SELECT DISTINCT pv FROM PlaceVol pv " +
                        "LEFT JOIN FETCH pv.reservations r " + // Charger reservations
                        "WHERE pv.vol = :vol";
                Query<PlaceVol> reservationsQuery = session.createQuery(reservationsHql, PlaceVol.class);
                reservationsQuery.setParameter("vol", vol);
                List<PlaceVol> placeVols = reservationsQuery.list();

                // Associer les placeVols chargés avec le vol
                vol.setPlaceVols(placeVols);

                // Étape 3 : Charger les promotions pour le vol
                String promotionsHql = "SELECT DISTINCT v FROM Vol v " +
                        "LEFT JOIN FETCH v.promotions pr " + // Charger promotions
                        "WHERE v.id = :id";
                Query<Vol> promotionsQuery = session.createQuery(promotionsHql, Vol.class);
                promotionsQuery.setParameter("id", id);
                Vol volWithPromotions = promotionsQuery.getSingleResult();

                // Associer les promotions chargées avec le vol
                vol.setPromotions(volWithPromotions.getPromotions());
            }

            return vol;
        }
    }

}