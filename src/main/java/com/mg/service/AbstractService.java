package com.mg.service;

import com.mg.dao.BaseDao;
import com.mg.dao.GenericDAO;
import java.util.List;

public abstract class AbstractService<T> {
    protected final GenericDAO<T> dao;

    protected AbstractService(GenericDAO<T> dao) {
        this.dao = dao;
    }

    public T findById(Class<T> clazz, Integer id, String... fetchAsso) {
        return dao.findById(clazz, id, fetchAsso);
    }

    public List<T> findAll(Class<T> clazz, String... fetchAsso) {
        return dao.findAll(clazz, fetchAsso);
    }

    public void save(T entity) {
        dao.save(entity);
    }

    public void update(T entity) {
        dao.update(entity);
    }

    public void delete(T entity) {
        dao.delete(entity);
    }
}