<%@ page import="com.mg.model.Parametre" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--            <% Parametre parametre=(Parametre) request.getAttribute("parametre"); String success=(String)--%>
<%--                request.getAttribute("success"); String error=(String) request.getAttribute("error"); %>--%>

                <!DOCTYPE html>
                <html lang="fr">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Configuration - Back Office</title>
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/back-office/css/style.css">
                </head>

                <body>
                    <!-- Navigation -->
                    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
                        <div class="container">
                            <a class="navbar-brand d-flex align-items-center"
                                href="${pageContext.request.contextPath}/admin">
                                <i class="bi bi-airplane-engines me-2"></i>Administration
                            </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav me-auto">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/vols">
                                            <i class="bi bi-airplane me-1"></i> Vols
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/promotions">
                                            <i class="bi bi-tag me-1"></i> Promotions
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active"
                                            href="${pageContext.request.contextPath}/admin/parametres">
                                            <i class="bi bi-gear me-1"></i> Paramètres
                                        </a>
                                    </li>
                                </ul>
                                <div class="navbar-nav">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
                                    </a>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <div class="container py-4">
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-header bg-white py-3">
                                        <h5 class="card-title mb-0">Configuration du système</h5>
                                    </div>
                                    <div class="card-body">
                                        <form action="${pageContext.request.contextPath}/admin/parametres/update"
                                            method="post" class="needs-validation" novalidate>
                                            <div class="row g-4">
                                                <div class="col-md-6">
                                                    <label for="delaiReservation" class="form-label">
                                                        <i class="bi bi-clock-history me-1"></i>
                                                        Délai minimum de réservation
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control"
                                                            name="delaiReservation" id="delaiReservation"
                                                            value="<%= request.getAttribute("delaiReservation") %>"
                                                        min="0" step="0.5" required>
                                                        <span class="input-group-text">heures</span>
                                                    </div>
                                                    <div class="form-text">
                                                        <i class="bi bi-info-circle me-1"></i>
                                                        Délai minimum requis avant le départ pour effectuer une
                                                        réservation
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="delaiAnnulation" class="form-label">
                                                        <i class="bi bi-x-circle me-1"></i>
                                                        Délai minimum d'annulation
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" name="delaiAnnulation"
                                                            id="delaiAnnulation" value="<%= request.getAttribute("delaiAnnulation") %>" min="0" step="0.5" required>
                                                        <span class="input-group-text">heures</span>
                                                    </div>
                                                    <div class="form-text">
                                                        <i class="bi bi-info-circle me-1"></i>
                                                        Délai minimum requis avant le départ pour annuler une
                                                        réservation
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="reductionEnfant" class="form-label">
                                                        <i class="bi bi-percent me-1"></i>
                                                        Réduction pour les enfants
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" name="reductionEnfant"
                                                            id="reductionEnfant" value="<%= request.getAttribute("reductionEnfant") %>" min="0" max="100" step="0.5" required>
                                                        <span class="input-group-text">%</span>
                                                    </div>
                                                    <div class="form-text">
                                                        <i class="bi bi-info-circle me-1"></i>
                                                        Pourcentage de réduction appliqué aux billets enfants
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="alert alert-info mt-4">
                                                <i class="bi bi-info-circle-fill me-2"></i>
                                                <strong>Note:</strong> Ces paramètres affectent les conditions de
                                                réservation et
                                                d'annulation pour tous les vols. Assurez-vous de définir des valeurs
                                                appropriées
                                                pour votre activité.
                                            </div>

                                            <div class="d-flex gap-2 mt-4">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-check-circle me-1"></i>
                                                    Enregistrer les modifications
                                                </button>
                                                <a href="${pageContext.request.contextPath}/admin"
                                                    class="btn btn-secondary">
                                                    <i class="bi bi-x-circle me-1"></i>
                                                    Annuler
                                                </a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="${pageContext.request.contextPath}/back-office/js/script.js"></script>
                    <script>
                        // Form validation
                        (function () {
                            'use strict'
                            var forms = document.querySelectorAll('.needs-validation')
                            Array.prototype.slice.call(forms).forEach(function (form) {
                                form.addEventListener('submit', function (event) {
                                    if (!form.checkValidity()) {
                                        event.preventDefault()
                                        event.stopPropagation()
                                    }
                                    form.classList.add('was-validated')
                                }, false)
                            })
                        })()
                    </script>

                </body>

                </html>