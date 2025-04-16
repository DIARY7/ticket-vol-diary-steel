package com.mg.service;

import com.mg.dao.UtilisateurDAO;
import com.mg.model.Utilisateur;

public class UtilisateurService extends AbstractService<Utilisateur> {
    private final UtilisateurDAO utilisateurDAO;

    public UtilisateurService() {
        super(new UtilisateurDAO());
        this.utilisateurDAO = (UtilisateurDAO) dao;
    }

    public Utilisateur login(String pseudo, String motDePasse) {
        return utilisateurDAO.findByPseudoAndPassword(pseudo, motDePasse);
    }

    public Utilisateur createUtilisateur(String nom, String prenom, String pseudo, String motDePasse, String role,String pdp) {
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom(nom);
        utilisateur.setPrenom(prenom);
        utilisateur.setPseudo(pseudo);
        utilisateur.setMotDePasse(motDePasse);
        utilisateur.setRole(role);
        utilisateur.setPdp(pdp);

        utilisateurDAO.save(utilisateur);
        return utilisateur;
    }
}