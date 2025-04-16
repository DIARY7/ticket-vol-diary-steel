package com.mg.dao;

import com.mg.model.Reservation;
import com.mg.model.Parametre;
import com.mg.model.Vol;
import com.mg.service.TransactionService;
import com.mg.service.exception.ServiceException;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.Calendar;
import java.util.List;

public class ReservationDAO extends BaseDao<Reservation> {

    public ReservationDAO() {
        super(Reservation.class);
    }

    public boolean isReservationAllowed(Vol vol) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Get system parameters
            Query<Parametre> paramQuery = session.createQuery("FROM Parametre p WHERE p.cle = 'delai_reservation'",
                    Parametre.class);
            Parametre param = paramQuery.setMaxResults(1).uniqueResult();

            if (param == null) {
                return false;
            }

            // Calculate the minimum allowed time before flight
            Calendar minTime = Calendar.getInstance();
            minTime.add(Calendar.HOUR, param.getValeur().intValue());

            return vol.getDateDepart().after(minTime.getTime());
        }
    }

    public boolean canCancelReservation(Reservation reservation) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Parametre> paramQuery = session.createQuery("FROM Parametre p WHERE p.cle = 'delai_annulation'",
                    Parametre.class);
            Parametre param = paramQuery.setMaxResults(1).uniqueResult();

            if (param == null) {
                return false;
            }

            Calendar minTime = Calendar.getInstance();
            minTime.add(Calendar.HOUR, param.getValeur().intValue());

            return reservation.getPlaceVol().getVol().getDateDepart().after(minTime.getTime());
        }
    }

    public List<Reservation> findByVol(Integer volId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Reservation r WHERE r.placeVol.vol.id = :volId";
            Query<Reservation> query = session.createQuery(hql, Reservation.class);
            query.setParameter("volId", volId);
            return query.list();
        }
    }

    public List<Reservation> findByUtilisateur(Integer userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Reservation r WHERE r.utilisateur.id = :userId ORDER BY r.placeVol.vol.dateDepart DESC";
            Query<Reservation> query = session.createQuery(hql, Reservation.class);
            query.setParameter("userId", userId);
            return query.list();
        }
    }

    public boolean cancelReservation(Integer reservationId) {
        return TransactionService.executeInTransaction(session -> {
            Reservation reservation = session.get(Reservation.class, reservationId);
            if (reservation != null && canCancelReservation(reservation)) {
                reservation.setValider(false);
                session.update(reservation);
                return true;
            }
            return false;
        });
    }

    public List<Reservation> findActiveReservations(Long volId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Reservation r WHERE r.placeVol.vol.id = :volId AND r.valider = true";
            Query<Reservation> query = session.createQuery(hql, Reservation.class);
            query.setParameter("volId", volId);
            return query.list();
        }
    }

    public long countActiveReservations() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(r) FROM Reservation r WHERE r.valider = true";
            Query<Long> query = session.createQuery(hql, Long.class);
            return query.uniqueResult();
        }
    }

    public List<Reservation> findRecentReservations() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Reservation r ORDER BY r.placeVol.vol.dateDepart DESC";
            Query<Reservation> query = session.createQuery(hql, Reservation.class);
            query.setMaxResults(10);
            return query.list();
        }
    }
}