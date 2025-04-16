package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.CustomSession;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.model.Utilisateur;
import com.mg.service.UtilisateurService;

import jakarta.servlet.http.Part;

@AnnotationCtrl
public class UtilisateurController {
    private final UtilisateurService utilisateurService = new UtilisateurService();

    @GET
    @Url("/profil")
    public ModelView profilDetail(CustomSession customSession) throws Exception {
        Utilisateur utilisateur = customSession.get("user") != null ? (Utilisateur) customSession.get("user") : null;
        if (utilisateur == null) {
            return new ModelView("/front-office/login.jsp");
        }
        ModelView modelView = new ModelView("/front-office/profil.jsp");
        modelView.addObject("utilisateur", utilisateur);
        return modelView;
    }


    @POST
    @Url("/uploadProfilePicture")
    public ModelView updatePdp(CustomSession session,@Param(name = "profilePicture") Part uploadFile) throws Exception {
        Utilisateur utilisateur = (Utilisateur) session.get("user");
        String pathName = "D:\\Etudes\\serveur\\tomcat10\\webapps\\ticket-vol\\img\\"; 
        System.out.println("Le nom du fichier est "+uploadFile.getSubmittedFileName());
        String fileName = utilisateur.getPseudo()+utilisateur.getPrenom()+"."+uploadFile.getSubmittedFileName().split("\\.")[1];
        uploadFile.write(pathName+fileName);

        utilisateur.setPdp(fileName);

        utilisateurService.update(utilisateur);
        session.add("user", utilisateur);
        ModelView modelView = new ModelView();
        modelView.setRedirect("/ticket-vol/profil");
        return modelView;
    }

}
