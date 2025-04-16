package com.mg.model;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "avion")
public class Avion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String modele;

    @Column(name = "date_fabrication")
    @Temporal(TemporalType.DATE)
    private Date dateFabrication;

    @OneToMany(mappedBy = "avion", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Place> places;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Date getDateFabrication() {
        return dateFabrication;
    }

    public void setDateFabrication(Date dateFabrication) {
        this.dateFabrication = dateFabrication;
    }


    public List<Place> getPlaces() {
        return places;
    }

    public void setPlaces(List<Place> places) {
        this.places = places;
    }
}