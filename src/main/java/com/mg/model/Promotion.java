package com.mg.model;

import javax.persistence.*;

@Entity
@Table(name = "promotion")
public class Promotion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Transient
    // @Required
    private Integer idVol;

    @Transient
    private Integer idTypeSiege;

    @Column(name = "nb_siege")
    private Integer nbSiege;

    @Column(name = "pourcentage_reduction")
    // @Required
    private Double pourcentageReduction;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_vol")
    private Vol vol;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_type_siege")
    private TypeSiege typeSiege;


    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Vol getVol() {
        return vol;
    }

    public void setVol(Vol vol) {
        this.vol = vol;
    }

    public TypeSiege getTypeSiege() {
        return typeSiege;
    }

    public void setTypeSiege(TypeSiege typeSiege) {
        this.typeSiege = typeSiege;
    }

    public Integer getNbSiege() {
        return nbSiege;
    }

    public void setNbSiege(Integer nbSiege) {
        this.nbSiege = nbSiege;
    }

    public Double getPourcentageReduction() {
        return pourcentageReduction;
    }

    public void setPourcentageReduction(Double pourcentageReduction) {
        this.pourcentageReduction = pourcentageReduction;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdTypeSiege() {
        return idTypeSiege;
    }

    public void setIdTypeSiege(Integer idTypeSiege) {
        this.idTypeSiege = idTypeSiege;
    }
}