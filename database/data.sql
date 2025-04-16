-- Insertion de données pour la table avion
INSERT INTO avion (modele, date_fabrication)
VALUES ('Airbus A320', '2015-06-15'),
    ('Boeing 737', '2012-09-10');
-- Insertion de données pour la table ville
INSERT INTO ville (nom)
VALUES ('Paris'),
    ('Lyon'),
    ('Marseille'),
    ('Londres'),
    ('New York');
-- Insertion de données pour la table utilisateur
INSERT INTO utilisateur (nom, prenom, role, pseudo, mot_de_passe)
VALUES (
        'Dupont',
        'Jean',
        'client',
        'jdupont',
        'password123'
    ),
    (
        'Martin',
        'Sophie',
        'admin',
        'smartin',
        'adminpass'
    ),
    (
        'Bernard',
        'Alice',
        'client',
        'abernard',
        'alicepwd'
    );
-- Insertion de données pour la table type_siege
INSERT INTO type_siege (designation)
VALUES ('Economique'),
    ('Business'),
    ('Première Classe');
-- Insertion des paramètres
INSERT INTO parametres (cle, valeur)
VALUES ('delai_reservation',24.0),
        ('delai_annulation', 48.0),
    ('reduc_enfant', 20.0);
-- Insertion de données pour la table vol
-- (les id_ville et id_avion font référence aux enregistrements insérés précédemment)
INSERT INTO vol (
        date_depart,
        id_ville_depart,
        id_ville_arrive,
        id_avion
    )
VALUES ('2025-03-01 08:00:00', 1, 2, 1),
    -- Vol de Paris à Lyon avec Airbus A320
    ('2025-03-02 12:30:00', 3, 1, 2),
    -- Vol de Marseille à Paris avec Boeing 737
    ('2025-03-05 19:45:00', 4, 5, 2);
-- Vol de Londres à New York avec Boeing 737
-- Insertion de données pour la table place (configuration des sièges dans les avions)
-- Pour l'avion 1 (Airbus A320)
INSERT INTO place (nombre, id_type_siege, id_avion)
VALUES (150, 1, 1),
    -- 150 sièges Economique
    (20, 2, 1),
    -- 20 sièges Business
    (10, 3, 1);
-- 10 sièges Première Classe
-- Pour l'avion 2 (Boeing 737)
INSERT INTO place (nombre, id_type_siege, id_avion)
VALUES (160, 1, 2),
    -- 160 sièges Economique
    (25, 2, 2),
    -- 25 sièges Business
    (5, 3, 2);
-- 5 sièges Première Classe
-- Insertion de données pour la table place_vol (tarifs des sièges pour chaque vol)
-- Pour le vol 1
INSERT INTO place_vol (prix, id_vol, id_place)
VALUES (120.50, 1, 1),
    -- Tarif Economique
    (250.00, 1, 2),
    -- Tarif Business
    (400.00, 1, 3);
-- Tarif Première Classe
-- Pour le vol 2
INSERT INTO place_vol (prix, id_vol, id_place)
VALUES (100.00, 2, 1),
    -- Tarif Economique
    (220.00, 2, 2),
    -- Tarif Business
    (350.00, 2, 3);
-- Tarif Première Classe
-- Pour le vol 3
INSERT INTO place_vol (prix, id_vol, id_place)
VALUES (150.00, 3, 1),
    -- Tarif Economique
    (300.00, 3, 2),
    -- Tarif Business
    (500.00, 3, 3);
-- Tarif Première Classe
-- Insertion de données pour la table promotion
INSERT INTO promotion (
        nb_siege,
        pourcentage_reduction,
        id_type_siege,
        id_vol
    )
VALUES (3, 10.0, 1, 1),
    -- Promotion sur les sièges Economique pour le vol 1 (réduction de 10% à partir de 3 sièges)
    (2, 15.0, 2, 2),
    -- Promotion sur les sièges Business pour le vol 2 (réduction de 15% à partir de 2 sièges)
    (1, 5.0, 3, 3);
-- Promotion sur les sièges Première Classe pour le vol 3 (réduction de 5%)
-- Insertion de données pour la table reservation
-- On se base sur l'ordre d'insertion de place_vol :
-- Pour le vol 1 : les enregistrements auront les id 1 (Economique), 2 (Business), 3 (Première Classe)
-- Pour le vol 2 : id 4, 5, 6
-- Pour le vol 3 : id 7, 8, 9
INSERT INTO reservation (
        prix,
        valider,
        nb_places,
        nb_adulte,
        nb_enfant,
        id_place_vol,
        id_utilisateur
    )
VALUES (120.50, true, 1, 1, 0, 1, 1),
    -- Réservation par Jean Dupont pour 1 adulte en Economique sur le vol 1
    (600.00, true, 3, 2, 1, 8, 3);
-- Réservation par Alice Bernard pour 2 adultes et 1 enfant en Business sur le vol 3