package com.mg.dao;

import com.mg.model.Avion;

public class AvionDAO extends BaseDao<Avion> {

    public AvionDAO() {
        super(Avion.class);
    }

    // On peut ajouter des méthodes spécifiques pour la recherche d'avions si
    // nécessaire
}