package com.mg.model;

import javax.persistence.*;

@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Double prix;

    @Column(columnDefinition = "boolean default true")
    private Boolean valider;

    @Column(name = "nb_places")
    private Integer nombrePlaces;

    @Column(name = "nb_adulte")
    private Integer nombreAdultes;

    @Column(name = "nb_enfant")
    private Integer nombreEnfants;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_utilisateur")
    private Utilisateur utilisateur;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_place_vol")
    private PlaceVol placeVol;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getPrix() {
        return prix;
    }

    public void setPrix(Double prix) {
        this.prix = prix;
    }

    public Boolean getValider() {
        return valider;
    }

    public void setValider(Boolean valider) {
        this.valider = valider;
    }

    public Integer getNombrePlaces() {
        return nombrePlaces;
    }

    public void setNombrePlaces(Integer nombrePlaces) {
        this.nombrePlaces = nombrePlaces;
    }

    public Integer getNombreAdultes() {
        return nombreAdultes;
    }

    public void setNombreAdultes(Integer nombreAdultes) {
        this.nombreAdultes = nombreAdultes;
    }

    public Integer getNombreEnfants() {
        return nombreEnfants;
    }

    public void setNombreEnfants(Integer nombreEnfants) {
        this.nombreEnfants = nombreEnfants;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public PlaceVol getPlaceVol() {
        return placeVol;
    }

    public void setPlaceVol(PlaceVol placeVol) {
        this.placeVol = placeVol;
    }
}