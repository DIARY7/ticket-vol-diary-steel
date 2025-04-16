package com.mg.service;

import com.mg.dao.PlaceDAO;
import com.mg.dao.AvionDAO;
import com.mg.dao.TypeSiegeDAO;
import com.mg.model.Place;
import com.mg.model.Avion;
import com.mg.model.TypeSiege;
import java.util.List;

public class PlaceService extends AbstractService<Place> {
    private final PlaceDAO placeDAO;
    private final AvionDAO avionDAO;
    private final TypeSiegeDAO typeSiegeDAO;

    public PlaceService() {
        super(new PlaceDAO());
        this.placeDAO = (PlaceDAO) dao;
        this.avionDAO = new AvionDAO();
        this.typeSiegeDAO = new TypeSiegeDAO();
    }

    public List<Place> findByAvion(Integer avionId) {
        return placeDAO.findByAvion(avionId);
    }

    public List<Place> findByAvionAndTypeSiege(Integer avionId, Integer typeSiegeId) {
        return placeDAO.findByAvionAndTypeSiege(avionId, typeSiegeId);
    }

    public Place createPlace(Integer avionId, Integer typeSiegeId, Integer nombre) {
        Place place = new Place();
        place.setAvion(avionDAO.findById(Avion.class, avionId));
        place.setTypeSiege(typeSiegeDAO.findById(TypeSiege.class, typeSiegeId));
        place.setNombre(nombre);
        
        placeDAO.save(place);
        return place;
    }

    public void updatePlace(Integer id, Integer typeSiegeId, Integer nombre) {
        Place place = placeDAO.findById(Place.class, id);
        if (place != null) {
            if (typeSiegeId != null) {
                place.setTypeSiege(typeSiegeDAO.findById(TypeSiege.class, typeSiegeId));
            }
            if (nombre != null) {
                place.setNombre(nombre);
            }
            placeDAO.update(place);
        }
    }

    public void deletePlace(Integer id) {
        Place place = placeDAO.findById(Place.class, id);
        if (place != null) {
            placeDAO.delete(place);
        }
    }

    public Place findById(Integer id) {
        return placeDAO.findById(Place.class, id);
    }
}