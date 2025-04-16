package com.mg.service;

import com.mg.dao.ParametreDAO;
import com.mg.model.Parametre;

public class ParametreService extends AbstractService<Parametre> {
    private final ParametreDAO parametreDAO;

    public ParametreService() {
        super(new ParametreDAO());
        this.parametreDAO = new ParametreDAO();
    }

    public Parametre findById(Class<Parametre> type, Object id) {
        return parametreDAO.findById(type, id);
    }

    public void saveParametre(String cle, Double valeur) {
        Parametre parametre = findById(Parametre.class, cle);
        if (parametre == null) {
            parametre = new Parametre();
            parametre.setCle(cle);
        }
        parametre.setValeur(valeur);
        if (parametre.getCle() == null) {
            parametreDAO.save(parametre);
        } else {
            parametreDAO.update(parametre);
        }
    }

    public Double getValeurParametre(String cle, Double defaultValue) {
        Parametre parametre = findById(Parametre.class, cle);
        return parametre != null ? parametre.getValeur() : defaultValue;
    }

    public void updateDelais(Double delaiReservation, Double delaiAnnulation) {
        saveParametre("delai_reservation", delaiReservation);
        saveParametre("delai_annulation", delaiAnnulation);
    }

    public void updateReductionEnfant(Double reduction) {
        saveParametre("reduc_enfant", reduction);
    }
}