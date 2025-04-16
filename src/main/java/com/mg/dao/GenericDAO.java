package com.mg.dao;

import java.util.List;

public interface GenericDAO<T> {
    T findById(Class<T> clazz, Integer id, String... fetchAssociations);

    List<T> findAll(Class<T> clazz, String... fetchAssociations);

    void save(T entity);

    void update(T entity);

    void delete(T entity);
}