package com.mg.dao;

import com.mg.service.TransactionService;
import com.mg.service.exception.ServiceException;
import com.mg.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class BaseDao<T> implements GenericDAO<T> {
    
    private final Class<T> entityClass;
    
    public BaseDao(Class<T> entityClass) {
        this.entityClass = entityClass;
    }
    
    @Override
    public T findById(Class<T> clazz, Integer id, String... fetchAssociations) {
        try {
            return TransactionService.executeInTransaction(session -> {
                StringBuilder hql = new StringBuilder("FROM " + clazz.getSimpleName() + " e");
                for (String association : fetchAssociations) {
                    hql.append(" LEFT JOIN FETCH e.").append(association);
                }
                hql.append(" WHERE e.id = :id");

                Query<T> query = session.createQuery(hql.toString(), clazz);
                query.setParameter("id", id);

                return query.uniqueResult();
            });
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la recherche par ID", e);
        }
    }

    @Override
    public List<T> findAll(Class<T> clazz, String... fetchAssociations) {
        try {
            return TransactionService.executeInTransaction(
                    session -> {
                        StringBuilder hql = new StringBuilder("SELECT DISTINCT e FROM " + clazz.getSimpleName() + " e");
                        for (String association : fetchAssociations) {
                            hql.append(" LEFT JOIN FETCH e.").append(association);
                        }
                        Query<T> query = session.createQuery(hql.toString(), clazz);
                        return query.getResultList();
                    });
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la récupération de tous les éléments", e);
        }
    }

    @Override
    public void save(T entity) {
        try {
            TransactionService.executeInTransactionWithoutResult(session -> {
                session.save(entity);
                return null;
            });
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la sauvegarde", e);
        }
    }

    @Override
    public void update(T entity) {
        try {
            TransactionService.executeInTransactionWithoutResult(session -> {
                session.update(entity);
                return null;
            });
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la mise à jour", e);
        }
    }

    @Override
    public void delete(T entity) {
        try {
            TransactionService.executeInTransactionWithoutResult(session -> {
                session.delete(entity);
                return null;
            });
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de la suppression", e);
        }
    }

    /**
     * Helper method to execute custom HQL queries
     * @param hql The HQL query to execute
     * @param params The parameters for the query
     * @return List of results
     */
    protected List<T> executeQuery(String hql, Object... params) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<T> query = session.createQuery(hql, entityClass);
            for (int i = 0; i < params.length; i += 2) {
                if (i + 1 < params.length) {
                    query.setParameter(params[i].toString(), params[i + 1]);
                }
            }
            return query.getResultList();
        } catch (Exception e) {
            throw new ServiceException("Erreur lors de l'exécution de la requête", e);
        }
    }
}
