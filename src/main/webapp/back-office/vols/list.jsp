<%@ page import="com.mg.model.Ville" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mg.model.Vol" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.mg.model.PlaceVol" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    Integer villeDepartId = (request.getAttribute("villeDepartId") != null) ?
            (Integer) request.getAttribute("villeDepartId") : null;
    Integer villeArriveId = (request.getAttribute("villeArriveId") != null) ?
            (Integer) request.getAttribute("villeArriveId") : null;
    String dateDebut = (request.getAttribute("dateDebut") != null) ? (String)
            request.getAttribute("dateDebut") : "";
    String dateFin = (request.getAttribute("dateFin") != null) ? (String)
            request.getAttribute("dateFin") : "";
    Double prixMin = (request.getAttribute("prixMin") != null) ? (Double)
            request.getAttribute("prixMin") : null;
    Double prixMax = (request.getAttribute("prixMax") != null) ? (Double)
            request.getAttribute("prixMax") : null;
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    DecimalFormat df = new DecimalFormat("#,##0.00 Ar");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Vols - Back Office</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
            rel="stylesheet">
    <link
            href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css"
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
                    <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container mt-5 pt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-airplane me-2"></i>Gestion des Vols</h2>
        <a href="${pageContext.request.contextPath}/admin/vols/create"
           class="btn btn-primary">
            <i class="bi bi-plus-circle me-2"></i>Nouveau Vol
        </a>
    </div>

    <!-- Alerts -->
    <% if (success != null && !success.isEmpty()) { %>
    <div class="alert alert-success alert-dismissible fade show"
         role="alert">
        <%= success %>
        <button type="button" class="btn-close"
                data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-danger alert-dismissible fade show"
         role="alert">
        <%= error %>
        <button type="button" class="btn-close"
                data-bs-dismiss="alert"
                aria-label="Close"></button>
    </div>
    <% } %>

    <!-- Filtres -->
    <div class="card mb-4">
        <div class="card-header bg-light">
            <h5
                    class="card-title mb-0 d-flex align-items-center">
                <i class="bi bi-funnel me-2"></i>
                <span>Filtres</span>
                <button
                        class="btn btn-link ms-auto p-0 toggle-filters"
                        type="button">
                    <i class="bi bi-chevron-down"></i>
                </button>
            </h5>
        </div>
        <div class="card-body filter-content">
            <form id="searchForm"
                  action="${pageContext.request.contextPath}/admin/vols"
                  method="get" class="row g-3">
                <div class="col-md-3">
                    <label for="villeDepartId"
                           class="form-label">Ville de
                        départ</label>
                    <select id="villeDepartId"
                            name="villeDepartId"
                            class="form-select">
                        <option value="">Toutes</option>
                        <% for (Ville ville : villes) { %>
                        <option
                                value="<%= ville.getId() %>"
                                <%=(villeDepartId != null &&
                                        ville.getId().equals(villeDepartId))
                                        ? "selected" : "" %>>
                            <%= ville.getNom() %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="col-md-3">
                    <label for="villeArriveId"
                           class="form-label">Ville
                        d'arrivée</label>
                    <select id="villeArriveId"
                            name="villeArriveId"
                            class="form-select">
                        <option value="">Toutes</option>
                        <% for (Ville ville : villes) { %>
                        <option
                                value="<%= ville.getId() %>"
                                <%=(villeArriveId != null &&
                                        ville.getId().equals(villeArriveId))
                                        ? "selected" : "" %>>
                            <%= ville.getNom() %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="col-md-3">
                    <label for="dateDebut"
                           class="form-label">Date
                        début</label>
                    <input type="datetime-local"
                           id="dateDebut" class="form-control"
                           name="dateDebut"
                           value="<%= dateDebut %>">
                </div>

                <div class="col-md-3">
                    <label for="dateFin"
                           class="form-label">Date fin</label>
                    <input type="datetime-local"
                           id="dateFin" class="form-control"
                           name="dateFin"
                           value="<%= dateFin %>">
                </div>

                <div class="col-md-3">
                    <label for="prixMin"
                           class="form-label">Prix min</label>
                    <div class="input-group">
                        <input type="number" id="prixMin"
                               step="0.01" class="form-control"
                               name="prixMin"
                               value="<%= prixMin != null ? prixMin : "" %>">
                        <span
                                class="input-group-text">Ar</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <label for="prixMax"
                           class="form-label">Prix max</label>
                    <div class="input-group">
                        <input type="number" id="prixMax"
                               step="0.01" class="form-control"
                               name="prixMax"
                               value="<%= prixMax != null ? prixMax : "" %>">
                        <span
                                class="input-group-text">Ar</span>
                    </div>
                </div>

                <div class="col-12">
                    <div class="d-flex gap-2">
                        <button type="submit"
                                class="btn btn-primary">
                            <i
                                    class="bi bi-search me-2"></i>Rechercher
                        </button>
                        <button type="button"
                                class="btn btn-secondary"
                                onclick="resetForm('searchForm')">
                            <i
                                    class="bi bi-x-circle me-2"></i>Réinitialiser
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Liste des vols -->
    <div class="card">
        <div class="card-body">
            <% if (vols == null || vols.isEmpty()) { %>
            <div class="alert alert-info">
                <i
                        class="bi bi-info-circle me-2"></i>Aucun
                vol ne correspond aux critères de
                recherche.
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table
                        class="table table-striped table-hover datatable">
                    <thead>
                    <tr>
                        <th>Vol N°</th>
                        <th>Avion</th>
                        <th>Départ</th>
                        <th>Arrivée</th>
                        <th>Date</th>
                        <th>Prix</th>
                        <th>
                            place
                        </th>
                        <th
                                style="width: 200px;">
                            Actions
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Vol vol : vols) { %>
                    <tr>

                        <td><%= vol.getId() %>
                        </td>
                        <td><%= vol.getAvion().getModele() %>
                        <td><%= vol.getVilleDepart().getNom() %>
                        </td>
                        <td><%= vol.getVilleArrive().getNom() %>
                        </td>
                        <td><%= vol.getDateDepart() %>
                        </td>
                        <td>
                            <%
                                for (PlaceVol placeVol : vol.getPlaceVols()) {
                                    String designation = placeVol.getPlace().getTypeSiege().getDesignation();
                                    double prix = placeVol.getPrix();
                            %>
                            <p><%= designation %> - <%= prix %>AR</p>
                            <%
                                }
                            %>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/vols/places?volId=<%= vol.getId() %>"
                               class="btn btn-sm btn-primary">
                                <i
                                        class="bi bi-eye me-1"></i>
                                Détails
                            </a>
                        </td>
                        <td>
                            <div
                                    class="btn-group">
                                <a href="${pageContext.request.contextPath}/admin/vols/edit?id=<%= vol.getId() %>"
                                   class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil me-1"></i>
                                    Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/vols/places?volId=<%= vol.getId() %>"
                                   class="btn btn-sm btn-info">
                                    <i class="bi bi-chair me-1"></i>
                                    Places
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/promotions?volId=<%= vol.getId() %>"
                                   class="btn btn-sm btn-info">
                                    <i
                                            class="bi bi-tag me-1"></i>
                                    Promotions
                                </a>
                                <button
                                        type="button"
                                        class="btn btn-sm btn-danger"
                                        onclick="confirmAndDelete(<%= vol.getId() %>)">
                                    <i
                                            class="bi bi-trash me-1"></i>
                                    Supprimer
                                </button>
                            </div>
                            <form
                                    id="deleteForm<%= vol.getId() %>"
                                    action="${pageContext.request.contextPath}/admin/vols/delete"
                                    method="post"
                                    style="display: none;">
                                <input
                                        type="hidden"
                                        name="id"
                                        value="<%= vol.getId() %>">
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
        src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script
        src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script
        src="${pageContext.request.contextPath}/back-office/js/script.js"></script>
<script>
    function confirmAndDelete(id) {
        if (confirm('Êtes-vous sûr de vouloir supprimer ce vol ?')) {
            document.getElementById('deleteForm' + id).submit();
        }
    }

    function resetForm() {
        document.getElementById('villeDepartId').value = '';
        document.getElementById('villeArriveId').value = '';
        document.getElementById('dateDebut').value = '';
        document.getElementById('dateFin').value = '';
        document.getElementById('prixMin').value = '';
        document.getElementById('prixMax').value = '';
        document.getElementById('searchForm').submit();
    }

    // Validation des dates
    document.getElementById('dateDebut').addEventListener('change', validateDates);
    document.getElementById('dateFin').addEventListener('change', validateDates);

    function validateDates() {
        const dateDebut = document.getElementById('dateDebut').value;
        const dateFin = document.getElementById('dateFin').value;

        if (dateDebut && dateFin && dateDebut > dateFin) {
            alert('La date de début doit être antérieure à la date de fin');
            document.getElementById('dateFin').value = '';
        }
    }

    // Validation des prix
    document.getElementById('prixMin').addEventListener('change', validatePrices);
    document.getElementById('prixMax').addEventListener('change', validatePrices);

    function validatePrices() {
        const prixMin = parseFloat(document.getElementById('prixMin').value);
        const prixMax = parseFloat(document.getElementById('prixMax').value);

        if (prixMin && prixMax && prixMin > prixMax) {
            alert('Le prix minimum doit être inférieur au prix maximum');
            document.getElementById('prixMax').value = '';
        }
    }

    // Auto-hide alerts after 5 seconds
    setTimeout(function () {
        document.querySelectorAll('.alert').forEach(function (alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>

</html>