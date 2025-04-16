<%@ page import="com.mg.model.Ville" %>
<%@ page import="com.mg.model.Vol" %>
<%@ page import="com.mg.model.Avion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% Vol vol = (Vol) request.getAttribute("vol");
    List<Ville> villes = (List<Ville>)
            request.getAttribute("villes");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
    String error = (String) request.getAttribute("error");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,##0.00 Ar");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <%= (vol != null) ? "Modifier" : "Créer" %> un Vol - Back Office
    </title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
            rel="stylesheet">
    <link
            href="${pageContext.request.contextPath}/back-office/css/style.css"
            rel="stylesheet">
</head>

<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center"
           href="${pageContext.request.contextPath}/admin">
            <i class="bi bi-airplane-engines me-2"></i>Administration
        </a>
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/admin/vols">
                        <i class="bi bi-airplane me-1"></i> Vols
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/admin/promotions">
                        <i class="bi bi-tag me-1"></i> Promotions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/admin/parametres">
                        <i class="bi bi-gear me-1"></i> Paramètres
                    </a>
                </li>
            </ul>
            <div class="navbar-nav">
                <a class="nav-link"
                   href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right me-1"></i>
                    Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container mt-5 pt-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header bg-light">
                    <h2 class="card-title mb-0">
                        <i class="bi bi-<%= (vol != null) ? " pencil"
                                                                            : "plus-circle" %> me-2"></i>
                        <%= (vol != null) ? "Modifier" : "Créer" %> un
                        Vol
                    </h2>
                </div>
                <div class="card-body">
                    <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger alert-dismissible fade show"
                         role="alert">
                        <i
                                class="bi bi-exclamation-triangle me-2"></i>
                        <%= error %>
                        <button type="button" class="btn-close"
                                data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <form
                            action="${pageContext.request.contextPath}/admin/vols/<%= (vol != null) ? "edit" : "create" %>"
                            method="post" class="needs-validation"
                            novalidate>

                        <% if (vol != null) { %>
                        <input type="hidden" name="id"
                               value="<%= vol.getId() %>">
                        <% } %>

                        <div class="row g-4">
                            <div class="col-md-6">
                                <label
                                        class="form-label"
                                        for="villeDepartId">
                                    <i
                                            class="bi bi-geo-alt me-1"></i>Ville
                                    de départ
                                    <span
                                            class="text-danger">*</span>
                                </label>
                                <select
                                        name="villeDepartId"
                                        id="villeDepartId"
                                        class="form-select"
                                        required>
                                    <option value="">
                                        Sélectionnez une
                                        ville
                                    </option>
                                    <% for (Ville ville
                                            : villes) { %>
                                    <option
                                            value="<%= ville.getId() %>"
                                            <%=(vol
                                                    != null &&
                                                    vol.getVilleDepart().getId().equals(ville.getId()))
                                                    ? "selected"
                                                    : "" %>>
                                        <%= ville.getNom()
                                        %>
                                    </option>
                                    <% } %>
                                </select>
                                <div
                                        class="invalid-feedback">
                                    Veuillez
                                    sélectionner la
                                    ville de départ
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label
                                        class="form-label"
                                        for="villeArriveId">
                                    <i
                                            class="bi bi-geo me-1"></i>Ville
                                    d'arrivée
                                    <span
                                            class="text-danger">*</span>
                                </label>
                                <select
                                        name="villeArriveId"
                                        id="villeArriveId"
                                        class="form-select"
                                        required>
                                    <option value="">
                                        Sélectionnez une
                                        ville
                                    </option>
                                    <% for (Ville ville
                                            : villes) { %>
                                    <option
                                            value="<%= ville.getId() %>"
                                            <%=(vol
                                                    != null &&
                                                    vol.getVilleArrive().getId().equals(ville.getId()))
                                                    ? "selected"
                                                    : "" %>>
                                        <%= ville.getNom()
                                        %>
                                    </option>
                                    <% } %>
                                </select>
                                <div
                                        class="invalid-feedback">
                                    Veuillez
                                    sélectionner la
                                    ville d'arrivée
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label
                                        class="form-label"
                                        for="avionId">
                                    <i
                                            class="bi bi-airplane me-1"></i>Avion
                                    <span
                                            class="text-danger">*</span>
                                </label>
                                <select name="avionId"
                                        id="avionId"
                                        class="form-select"
                                        required>
                                    <option value="">
                                        Sélectionnez un
                                        avion
                                    </option>
                                    <% for (Avion avion
                                            : avions) { %>
                                    <option
                                            value="<%= avion.getId() %>"
                                            <%=(vol
                                                    != null &&
                                                    vol.getAvion().getId().equals(avion.getId()))
                                                    ? "selected"
                                                    : "" %>>
                                        <%= avion.getModele()
                                        %>
                                        (Fabriqué
                                        le: <%=
                                    sdfDisplay.format(avion.getDateFabrication())
                                    %>)
                                    </option>
                                    <% } %>
                                </select>
                                <div
                                        class="invalid-feedback">
                                    Veuillez
                                    sélectionner un
                                    avion
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label
                                        class="form-label"
                                        for="dateDepart">
                                    <i
                                            class="bi bi-calendar-event me-1"></i>Date
                                    et heure de départ
                                    <span
                                            class="text-danger">*</span>
                                </label>
                                <input
                                        type="datetime-local"
                                        class="form-control"
                                        id="dateDepart"
                                        name="dateDepart"
                                        value="<%= (vol != null) ? sdf.format(vol.getDateDepart()) : "" %>"
                                        required>
                                <div
                                        class="invalid-feedback">
                                    Veuillez
                                    sélectionner la date
                                    et l'heure de départ
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-4">
                            <button type="submit"
                                    class="btn btn-primary">
                                <i
                                        class="bi bi-check-circle me-1"></i>
                                <%= (vol != null)
                                        ? "Modifier"
                                        : "Créer" %> le vol
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/vols"
                               class="btn btn-secondary">
                                <i
                                        class="bi bi-x-circle me-1"></i>Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
        src="${pageContext.request.contextPath}/back-office/js/script.js"></script>
<script>
    (function () {
        'use strict';

        // Form validation
        var forms = document.querySelectorAll('.needs-validation');
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });

        // Custom validation for departure and arrival cities
        document.getElementById('villeDepartId').addEventListener('change', validateCities);
        document.getElementById('villeArriveId').addEventListener('change', validateCities);

        function validateCities() {
            const villeDepartId = document.getElementById('villeDepartId').value;
            const villeArriveId = document.getElementById('villeArriveId').value;

            if (villeDepartId && villeArriveId && villeDepartId === villeArriveId) {
                alert('La ville de départ et d\'arrivée ne peuvent pas être identiques');
                document.getElementById('villeArriveId').value = '';
            }
        }

        // Price validation
        document.getElementById('prix').addEventListener('input', function (e) {
            const prix = parseFloat(e.target.value);
            if (prix <= 0) {
                e.target.setCustomValidity('Le prix doit être supérieur à 0');
            } else {
                e.target.setCustomValidity('');
            }
        });

        // Date validation
        document.getElementById('dateDepart').addEventListener('change', function (e) {
            const dateDepart = new Date(e.target.value);
            const now = new Date();

            if (dateDepart < now) {
                e.target.setCustomValidity('La date de départ ne peut pas être dans le passé');
            } else {
                e.target.setCustomValidity('');
            }
        });
    })();
</script>
</body>

</html>