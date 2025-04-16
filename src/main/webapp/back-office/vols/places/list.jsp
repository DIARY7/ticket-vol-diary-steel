<%@ page import="com.mg.model.Vol" %>
<%@ page import="com.mg.model.PlaceVol" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% Vol vol = (Vol) request.getAttribute("vol");
    List<PlaceVol> placeVols = vol.getPlaceVols();
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    DecimalFormat df = new DecimalFormat("#,##0.00 Ar");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Places - Vol <%= vol.getId() %>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
          rel="stylesheet">
    <link href="${pageContext.request.contextPath}/back-office/css/style.css" rel="stylesheet">
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-airplane-seat me-2"></i>Places du Vol <%= vol.getId() %>
        </h2>
        <div>
            <a href="${pageContext.request.contextPath}/admin/vols"
               class="btn btn-secondary me-2">
                <i class="bi bi-arrow-left me-2"></i>Retour aux vols
            </a>
            <a href="${pageContext.request.contextPath}/admin/vols/places/create?volId=<%= vol.getId() %>"
               class="btn btn-primary">
                <i class="bi bi-plus-circle me-2"></i>Nouvelle Place
            </a>
        </div>
    </div>

    <!-- Alerts -->
    <% if (success != null && !success.isEmpty()) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"
                aria-label="Close"></button>
    </div>
    <% } %>

    <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"
                aria-label="Close"></button>
    </div>
    <% } %>

    <!-- Liste des places -->
    <div class="card">
        <div class="card-body">
            <% if (placeVols == null || placeVols.isEmpty()) { %>
            <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i>Aucune place n'est
                définie pour ce vol.
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type de Siège</th>
                        <th>Prix</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (PlaceVol placeVol : placeVols) { %>
                    <tr>
                        <td>
                            <%= placeVol.getId() %>
                        </td>
                        <td>
                            <%= placeVol.getPlace().getTypeSiege().getDesignation()
                            %>
                        </td>
                        <td>
                            <%= df.format(placeVol.getPrix())
                            %>
                        </td>
                        <td>
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/admin/vols/places/edit?id=<%= placeVol.getId() %>&volId=<%= vol.getId() %>"
                                   class="btn btn-sm btn-warning">
                                    <i
                                            class="bi bi-pencil me-1"></i>Modifier
                                </a>
                                <button type="button"
                                        class="btn btn-sm btn-danger"
                                        onclick="confirmAndDelete(<%= placeVol.getId() %>, <%= vol.getId() %>)">
                                    <i
                                            class="bi bi-trash me-1"></i>Supprimer
                                </button>
                            </div>
                            <form
                                    id="deleteForm<%= placeVol.getId() %>"
                                    action="${pageContext.request.contextPath}/admin/vols/places/delete"
                                    method="post"
                                    style="display: none;">
                                <input type="hidden"
                                       name="id"
                                       value="<%= placeVol.getId() %>">
                                <input type="hidden"
                                       name="volId"
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
<script>
    function confirmAndDelete(id, volId) {
        if (confirm('Êtes-vous sûr de vouloir supprimer cette place ?')) {
            document.getElementById('deleteForm' + id).submit();
        }
    }
</script>
</body>

</html>