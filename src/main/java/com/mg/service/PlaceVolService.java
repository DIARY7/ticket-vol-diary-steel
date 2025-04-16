package com.mg.service;

import com.mg.dao.*;
import com.mg.model.PlaceVol;

public class PlaceVolService extends AbstractService<PlaceVol> {
    private final PlaceVolDAO placeVolDAO;

    public PlaceVolService() {
        super(new PlaceVolDAO());
        this.placeVolDAO = new PlaceVolDAO();
    }
}
