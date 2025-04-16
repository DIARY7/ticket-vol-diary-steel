package com.mg.service;

import com.mg.dao.VilleDAO;
import com.mg.model.Ville;
import java.util.List;

public class VilleService extends AbstractService<Ville> {
    private final VilleDAO villeDAO;

    public VilleService() {
        super(new VilleDAO());
        this.villeDAO = (VilleDAO) dao;
    }

    public List<Ville> findByNom(String nom) {
        return villeDAO.findByNom(nom);
    }

    public Ville findById(Integer integer){
        return villeDAO.findById(Ville.class,integer);
    }

    public List<Ville> findVillesDepartWithVols() {
        return villeDAO.findVillesDepartWithVols();
    }

    public List<Ville> findVillesArriveePourVilleDepart(Integer villeDepartId) {
        return villeDAO.findVillesArriveePourVilleDepart(villeDepartId);
    }
}