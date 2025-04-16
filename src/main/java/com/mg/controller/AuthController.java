package com.mg.controller;

import mg.itu.prom16.annotation.AnnotationCtrl;
import mg.itu.prom16.annotation.GET;
import mg.itu.prom16.annotation.POST;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.utilitaire.CustomSession;
import mg.itu.prom16.utilitaire.ModelView;

import com.mg.service.UtilisateurService;
import com.mg.model.Utilisateur;

@AnnotationCtrl
public class AuthController {
    private final UtilisateurService utilisateurService;

    public AuthController() {
        this.utilisateurService = new UtilisateurService();
    }

    @GET
    @Url("/loginForm")
    public ModelView loginForm() throws Exception {
        return new ModelView("/front-office/login.jsp");
    }

    @POST
    @Url("/login")
    public ModelView login(
            @Param(name = "pseudo") String pseudo,
            @Param(name = "motDePasse") String motDePasse,
            CustomSession customSession) throws Exception {

        Utilisateur utilisateur = utilisateurService.login(pseudo, motDePasse);
        ModelView modelView = new ModelView();
        if (utilisateur != null) {
            customSession.add("user", utilisateur);
            customSession.add("role", utilisateur.getRole());
            if ("admin".equals(utilisateur.getRole())) {
                modelView.setUrl("/back-office/index.jsp");
            } else {
                modelView.setRedirect("/ticket-vol/vols/search");
            }
        }else {
            modelView.setUrl("/front-office/login.jsp");
            modelView.addObject("error", "Nom d'utilisateur ou mot de passe incorrect");
        }

        return modelView;
    }


    @GET
    @Url("/logout")
    public ModelView logout(CustomSession session) throws Exception {
        session.destroy();
        ModelView model = new ModelView();
        model.setRedirect("/ticket-vol/loginForm");
        return model;
    }
}