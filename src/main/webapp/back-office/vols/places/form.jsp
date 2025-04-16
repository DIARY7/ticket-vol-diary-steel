<%@ page import="com.mg.model.Vol" %>
    <%@ page import="com.mg.model.PlaceVol" %>
        <%@ page import="com.mg.model.TypeSiege" %>
        <%@ page import="com.mg.model.Place" %>
            <%@ page import="java.util.List" %>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

                    <% Vol vol=(Vol) request.getAttribute("vol"); 
                       PlaceVol placeVol=(PlaceVol) request.getAttribute("placeVol"); 
                       List<Place> places = (List<Place>) request.getAttribute("places");
                       String error = (String) request.getAttribute("error");
                    %>

                            <!DOCTYPE html>
                            <html lang="fr">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>
                                    <%= (placeVol !=null) ? "Modifier" : "Créer" %> une Place - Vol <%= vol.getId() %>
                                </title>
                                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
                                    rel="stylesheet">
                                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
                                    rel="stylesheet">
                                <link href="${pageContext.request.contextPath}/back-office/css/style.css"
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
                                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#navbarNav">
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
                                                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                                    <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
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
                                                        <i class="bi bi-<%= (placeVol != null) ? " pencil"
                                                            : "plus-circle" %> me-2"></i>
                                                        <%= (placeVol !=null) ? "Modifier" : "Créer" %> une Place - Vol
                                                            <%= vol.getId() %>
                                                    </h2>
                                                </div>
                                                <div class="card-body">
                                                    <% if (error !=null && !error.isEmpty()) { %>
                                                        <div class="alert alert-danger alert-dismissible fade show"
                                                            role="alert">
                                                            <i class="bi bi-exclamation-triangle me-2"></i>
                                                            <%= error %>
                                                                <button type="button" class="btn-close"
                                                                    data-bs-dismiss="alert"></button>
                                                        </div>
                                                        <% } %>

                                                            <form
                                                                action="${pageContext.request.contextPath}/admin/vols/places/<%= (placeVol != null) ? "edit" : "create" %>"
                                                                method="post" class="needs-validation" novalidate>

                                                                <% if (placeVol !=null) { %>
                                                                    <input type="hidden" name="id"
                                                                        value="<%= placeVol.getId() %>">
                                                                    <% } %>
                                                                        <input type="hidden" name="volId"
                                                                            value="<%= vol.getId() %>">

                                                                        <div class="mb-3">
                                                                            <label for="placeId" class="form-label">
                                                                                <i class="bi bi-chair me-1"></i>Place
                                                                                <span class="text-danger">*</span>
                                                                            </label>
                                                                            <select name="placeId" id="placeId"
                                                                                class="form-select" required>
                                                                                <option value="">Sélectionnez une place</option>
                                                                                <% for (Place place : places) { %>
                                                                                    <option
                                                                                        value="<%= place.getId() %>"
                                                                                        <%=(placeVol !=null &&
                                                                                        placeVol.getPlace().getId().equals(place.getId()))
                                                                                        ? "selected" : "" %>>
                                                                                        <%= place.getTypeSiege().getDesignation() %> (<%=place.getNombre()%> places)
                                                                                    </option>
                                                                                    <% } %>
                                                                            </select>
                                                                            <div class="invalid-feedback">
                                                                                Veuillez sélectionner une place
                                                                            </div>
                                                                        </div>

                                                                        <div class="mb-3">
                                                                            <label for="prix" class="form-label">
                                                                                <i
                                                                                    class="bi bi-currency-dollar me-1"></i>Prix
                                                                                <span class="text-danger">*</span>
                                                                            </label>
                                                                            <div class="input-group">
                                                                                <input type="number" step="0.01"
                                                                                    class="form-control" id="prix"
                                                                                    name="prix"
                                                                                    value="<%= (placeVol != null) ? placeVol.getPrix() : "" %>"
                                                                                    required>
                                                                                <span class="input-group-text">Ar</span>
                                                                                <div class="invalid-feedback">
                                                                                    Veuillez entrer un prix valide
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="d-flex gap-2">
                                                                            <button type="submit"
                                                                                class="btn btn-primary">
                                                                                <i class="bi bi-check-circle me-1"></i>
                                                                                <%= (placeVol !=null) ? "Modifier"
                                                                                    : "Créer" %>
                                                                            </button>
                                                                            <a href="${pageContext.request.contextPath}/admin/vols/places?volId=<%= vol.getId() %>"
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
                                <script>
                                    (function () {
                                        'use strict';

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

                                        // Price validation
                                        document.getElementById('prix').addEventListener('input', function (e) {
                                            const prix = parseFloat(e.target.value);
                                            if (prix <= 0) {
                                                e.target.setCustomValidity('Le prix doit être supérieur à 0');
                                            } else {
                                                e.target.setCustomValidity('');
                                            }
                                        });
                                    })();
                                </script>
                            </body>

                            </html>