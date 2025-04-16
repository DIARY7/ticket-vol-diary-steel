<%@ page import="com.mg.model.Vol" %>
<%@ page import="com.mg.model.Promotion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<Promotion> promotions = (List<Promotion>) request.getAttribute("promotions");
    Vol selectedVol = (Vol) request.getAttribute("selectedVol");
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Promotions - Back Office</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
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
            <button class="navbar-toggler" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/vols">
                            <i class="bi bi-airplane me-1"></i> Vols
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active"
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
            <h2><i class="bi bi-tag me-2"></i>Gestion des Promotions</h2>
            <a href="${pageContext.request.contextPath}/admin/promotions/create<%= selectedVol != null ? "?volId=" + selectedVol.getId() : "" %>"
               class="btn btn-primary">
                <i class="bi bi-plus-circle me-2"></i>Nouvelle Promotion
            </a>
        </div>

        <% if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i><%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i><%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Filtres -->
        <div class="card mb-4">
            <div class="card-header bg-light">
                <h5 class="card-title mb-0 d-flex align-items-center">
                    <i class="bi bi-funnel me-2"></i>Filtres
                </h5>
            </div>
            <div class="card-body filter-content">
                <form action="${pageContext.request.contextPath}/admin/promotions" method="get" class="row g-3">
                    <div class="col-md-6">
                        <label for="volId" class="form-label">Filtrer par vol</label>
                        <select name="volId" id="volId" class="form-select" onchange="this.form.submit()">
                            <option value="">Tous les vols</option>
                            <% for (Vol vol : vols) { %>
                                <option value="<%= vol.getId() %>"
                                        <%= (selectedVol != null && vol.getId().equals(selectedVol.getId())) ? "selected" : "" %>>
                                    <%= vol.getVilleDepart().getNom() %> → <%= vol.getVilleArrive().getNom() %>
                                    (<%= sdf.format(vol.getDateDepart()) %>)
                                </option>
                            <% } %>
                        </select>
                    </div>
                </form>
            </div>
        </div>

        <!-- Liste des promotions -->
        <div class="card">
            <div class="card-body">
                <% if (promotions == null || promotions.isEmpty()) { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>
                        Aucune promotion n'a été trouvée.
                        <% if (selectedVol != null) { %>
                            <br>
                            <small>Filtré pour le vol: <%= selectedVol.getVilleDepart().getNom() %> → <%= selectedVol.getVilleArrive().getNom() %></small>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover datatable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Vol</th>
                                    <th>Type de Siège</th>
                                    <th>Nombre de sièges</th>
                                    <th>Réduction</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Promotion promotion : promotions) { %>
                                    <tr>
                                        <td><%= promotion.getId() %></td>
                                        <td>
                                            <span class="d-flex align-items-center">
                                                <i class="bi bi-airplane me-2"></i>
                                                <%= promotion.getVol().getVilleDepart().getNom() %> →
                                                <%= promotion.getVol().getVilleArrive().getNom() %>
                                                <br>
                                                <small class="text-muted">
                                                    <i class="bi bi-calendar-event me-1"></i>
                                                    <%= sdf.format(promotion.getVol().getDateDepart()) %>
                                                </small>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-info">
                                                <%= promotion.getTypeSiege().getDesignation() %>
                                            </span>
                                        </td>
                                        <td><%= promotion.getNbSiege() %></td>
                                        <td>
                                            <span class="badge bg-success">
                                                <%= promotion.getPourcentageReduction() %>%
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-action-group">
                                                <form action="${pageContext.request.contextPath}/admin/promotions/delete"
                                                      method="post" style="display: inline;"
                                                      onsubmit="return confirmDelete('<%= promotion.getVol().getVilleDepart().getNom() %> → <%= promotion.getVol().getVilleArrive().getNom() %>')">
                                                    <input type="hidden" name="id" value="<%= promotion.getId() %>">
                                                    <input type="hidden" name="volId" value="<%= promotion.getVol().getId() %>">
                                                    <button type="submit" class="btn btn-sm btn-danger">
                                                        <i class="bi bi-trash me-1"></i>Supprimer
                                                    </button>
                                                </form>
                                            </div>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="${pageContext.request.contextPath}/back-office/js/script.js"></script>
</body>

</html>