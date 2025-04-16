package com.mg.service;

import com.mg.service.exception.ServiceException;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class TransactionService {
    public interface TransactionCallback<T> {
        T execute(Session session) throws Exception;
    }

    public static <T> T executeInTransaction(TransactionCallback<T> callback) throws ServiceException {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();

            T result = callback.execute(session);

            transaction.commit();
            return result;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new ServiceException("Erreur lors de l'exécution de la transaction", e);
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public static void executeInTransactionWithoutResult(TransactionCallback<Void> callback) throws ServiceException {
        executeInTransaction(callback);
    }
}