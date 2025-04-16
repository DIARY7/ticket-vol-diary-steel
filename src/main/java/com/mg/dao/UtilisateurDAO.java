package com.mg.dao;

import com.mg.model.Utilisateur;
import com.mg.utils.HibernateUtil;
import com.mg.service.TransactionService;
import com.mg.service.exception.ServiceException;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class UtilisateurDAO extends BaseDao<Utilisateur> {

    public UtilisateurDAO() {
        super(Utilisateur.class);
    }

    public Utilisateur findByUsername(String username) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Utilisateur> query = session.createQuery(
                    "FROM Utilisateur WHERE pseudo = :username",
                    Utilisateur.class);
            query.setParameter("username", username);
            return query.uniqueResult();
        }
    }

    public Utilisateur findByPseudoAndPassword(String pseudo, String motDePasse) {
        try {
            return TransactionService.executeInTransaction(session -> {
                String hql = "FROM Utilisateur u WHERE u.pseudo = :pseudo AND u.motDePasse = :motDePasse";
                Query<Utilisateur> query = session.createQuery(hql, Utilisateur.class);
                query.setParameter("pseudo", pseudo);
                query.setParameter("motDePasse", motDePasse);
                return query.uniqueResult();
            });
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'authentification", e);
        }
    }
}
