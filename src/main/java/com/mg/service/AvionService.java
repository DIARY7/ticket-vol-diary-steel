package com.mg.service;

import com.mg.dao.AvionDAO;
import com.mg.dao.PlaceDAO;
import com.mg.dao.TypeSiegeDAO;
import com.mg.model.Avion;
import com.mg.model.Place;
import com.mg.model.TypeSiege;
import java.util.Date;
import java.util.List;

public class AvionService extends AbstractService<Avion> {
    private final AvionDAO avionDAO;
    private final PlaceDAO placeDAO;
    private final TypeSiegeDAO typeSiegeDAO;

    public AvionService() {
        super(new AvionDAO());
        this.avionDAO = (AvionDAO) dao;
        this.placeDAO = new PlaceDAO();
        this.typeSiegeDAO = new TypeSiegeDAO();
    }

    public Avion createAvion(String modele, Date dateFabrication, int[] typeSiegeIds, int[] nombrePlaces) {
        Avion avion = new Avion();
        avion.setModele(modele);
        avion.setDateFabrication(dateFabrication);
        avionDAO.save(avion);

        for (int i = 0; i < typeSiegeIds.length; i++) {
            if (typeSiegeIds[i] != 0 &&  nombrePlaces[i] > 0) {
                Place place = new Place();
                place.setAvion(avion);
                place.setTypeSiege(typeSiegeDAO.findById(TypeSiege.class, typeSiegeIds[i]));
                place.setNombre(nombrePlaces[i]);
                placeDAO.save(place);
            }
        }

        return avion;
    }

    public void updateAvion(int id, String modele, Date dateFabrication, int[] typeSiegeIds,
            int[] nombrePlaces) {
        Avion avion = avionDAO.findById(Avion.class, id);
        if (avion != null) {
            avion.setModele(modele);
            avion.setDateFabrication(dateFabrication);
            avionDAO.update(avion);

            // Delete existing places
            List<Place> existingPlaces = placeDAO.findByAvion(id);
            for (Place place : existingPlaces) {
                placeDAO.delete(place);
            }

            // Create new places
            for (int i = 0; i < typeSiegeIds.length; i++) {
                if (typeSiegeIds[i] !=0 && nombrePlaces[i] > 0) {
                    Place place = new Place();
                    place.setAvion(avion);
                    place.setTypeSiege(typeSiegeDAO.findById(TypeSiege.class, typeSiegeIds[i]));
                    place.setNombre(nombrePlaces[i]);
                    placeDAO.save(place);
                }
            }
        }
    }

    public void deleteAvion(Integer id) {
        Avion avion = avionDAO.findById(Avion.class, id);
        if (avion != null) {
            List<Place> places = placeDAO.findByAvion(id);
            for (Place place : places) {
                placeDAO.delete(place);
            }
            avionDAO.delete(avion);
        }
    }
}