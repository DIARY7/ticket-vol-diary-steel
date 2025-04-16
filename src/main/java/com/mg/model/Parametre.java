package com.mg.model;

import javax.persistence.*;

@Entity
@Table(name = "parametres")
public class Parametre {
    @Id
    @Column(name = "cle")
    private String cle;

    @Column(name = "valeur")
    private String valeur;

    // Getters and Setters
    public String getCle() {
        return cle;
    }

    public void setCle(String cle) {
        this.cle = cle;
    }

    public Double getValeur() {
        return Double.parseDouble(valeur);
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur.toString();
    }
}