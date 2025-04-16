CREATE DATABASE ticket_vol;
\c ticket_vol;
CREATE TABLE avion (
    id SERIAL,
    modele VARCHAR(50),
    date_fabrication DATE,
    PRIMARY KEY (id)
);
CREATE TABLE ville (
    id SERIAL,
    nom VARCHAR(50),
    PRIMARY KEY (id)
);
CREATE TABLE vol (
    id SERIAL,
    date_depart TIMESTAMP,
    id_ville_depart INTEGER NOT NULL,
    id_ville_arrive INTEGER NOT NULL,
    id_avion INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_ville_depart) REFERENCES ville (id),
    FOREIGN KEY (id_ville_arrive) REFERENCES ville (id),
    FOREIGN KEY (id_avion) REFERENCES avion (id)
);
CREATE TABLE utilisateur (
    id SERIAL,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    role VARCHAR(50),
    pseudo VARCHAR(50),
    mot_de_passe VARCHAR(255),
    pdp text,
    PRIMARY KEY (id)
);
CREATE TABLE type_siege (
    id SERIAL,
    designation VARCHAR(50),
    PRIMARY KEY (id)
);
CREATE TABLE parametres(
    cle VARCHAR(50),
    valeur VARCHAR(50),
    PRIMARY KEY(cle)
);
CREATE TABLE place (
    id SERIAL,
    nombre INTEGER,
    id_type_siege INTEGER NOT NULL,
    id_avion INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_type_siege) REFERENCES type_siege (id),
    FOREIGN KEY (id_avion) REFERENCES avion (id)
);
CREATE TABLE place_vol (
    id SERIAL,
    prix DOUBLE PRECISION,
    id_vol INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_vol) REFERENCES vol (id),
    FOREIGN KEY (id_place) REFERENCES place (id)
);
CREATE TABLE promotion (
    id SERIAL,
    nb_siege INTEGER,
    pourcentage_reduction DOUBLE PRECISION,
    id_type_siege INTEGER NOT NULL,
    id_vol INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_type_siege) REFERENCES type_siege (id),
    FOREIGN KEY (id_vol) REFERENCES vol (id)
);
CREATE TABLE reservation (
    Id SERIAL,
    prix DOUBLE PRECISION,
    valider BOOLEAN default true,
    nb_places INTEGER,
    nb_adulte INTEGER,
    nb_enfant INTEGER,
    id_place_vol INTEGER NOT NULL,
    id_utilisateur INTEGER NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (id_place_vol) REFERENCES place_vol (id),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id)
);