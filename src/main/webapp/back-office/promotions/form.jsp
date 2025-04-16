<%@ page import="com.mg.model.Vol" %>
<%@ page import="com.mg.model.TypeSiege" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%


    Integer volId = (Integer)request.getAttribute("promotion.idVol");
    Integer typeSiegeId = (Integer)request.getAttribute("promotion.idTypeSiege");
    Integer nbSiege = (Integer)request.getAttribute("promotion.nbSiege");
    Double pourcentageReduction = (Double)request.getAttribute("promotion.pourcentageReduction");

    List<Vol> vols = (List<Vol>)request.getAttribute("vols");
    List<TypeSiege> typeSieges = (List<TypeSiege>) request.getAttribute("typeSieges");
    Vol selectedVol = (Vol) request.getAttribute("selectedVol");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Promotion - Back Office</title>
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
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="bi bi-tag me-2"></i>Nouvelle Promotion</h2>
                </div>

                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="card-title mb-0">Informations de la promotion</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/promotions/create"
                              method="post" class="needs-validation" novalidate>

                            <div class="row g-4">
                                <div class="col-md-12">
                                    <label for="idVol" class="form-label">
                                        <i class="bi bi-airplane me-1"></i>Vol
                                        <span class="text-danger">*</span>
                                    </label>
                                    <select name="promotion.idVol" id="idVol" class="form-select" required>
                                        <option value="">Sélectionnez un vol</option>
                                        <% for (Vol vol : vols) { %>
                                            <option value="<%= vol.getId() %>"
                                                    <%=(volId!= null && volId.equals(vol.getId()))? "selected" : "" %>>
                                                <%= vol.getVilleDepart().getNom() %> →
                                                <%= vol.getVilleArrive().getNom() %>
                                                (<%= sdf.format(vol.getDateDepart())%>)
                                            </option>
                                        <% } %>
                                    </select>
                                    <% if (request.getAttribute("error_idVol") != null) { %>
                                    <span style="color: red;"><%= request.getAttribute("error_idVol") %></span>
                                    <% } %>
                                    <div class="invalid-feedback">
                                        Veuillez sélectionner un vol
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label for="idTypeSiege" class="form-label">
                                        <i class="bi bi-chair me-1"></i>Type de Siège
                                        <span class="text-danger">*</span>
                                    </label>
                                    <select name="promotion.idTypeSiege" id="idTypeSiege" class="form-select" required>
                                        <option value="">Sélectionnez un type de siège</option>
                                        <% for (TypeSiege typeSiege : typeSieges) { %>
                                            <option value="<%= typeSiege.getId() %>"
                                                    <%=(typeSiegeId!= null && typeSiegeId.equals(typeSiege.getId()))? "selected" : "" %>
                                            >
                                                <%= typeSiege.getDesignation() %>
                                            </option>
                                        <% } %>
                                    </select>
                                    <% if (request.getAttribute("error_idTypeSiege") != null) { %>
                                    <span style="color: red;"><%= request.getAttribute("error_idTypeSiege") %></span>
                                    <% } %>
                                    <div class="invalid-feedback">
                                        Veuillez sélectionner un type de siège
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label for="nbSiege" class="form-label">
                                        <i class="bi bi-people me-1"></i>Nombre de sieges en promotion
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input type="number" class="form-control" id="nbSiege"
                                           name="promotion.nbSiege" min="1"
                                             value="<%= nbSiege != null ? nbSiege : "" %>"
                                           required>
                                    <% if (request.getAttribute("error_nbSiege") != null) { %>
                                    <span style="color: red;"><%= request.getAttribute("error_nbSiege") %></span>
                                    <% } %>
                                    <div class="form-text">
                                        Nombre de sieges disponibles pour cette promotion
                                    </div>
                                    <div class="invalid-feedback">
                                        Veuillez entrer un nombre de sieges valide (minimum 1)
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label for="pourcentageReduction" class="form-label">
                                        <i class="bi bi-percent me-1"></i>Pourcentage de réduction
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control percentage-input"
                                               id="pourcentageReduction" name="promotion.pourcentageReduction" min="0"
                                               max="100" step="0.01"
                                                  value="<%= pourcentageReduction != null ? pourcentageReduction : "" %>"
                                               required>
                                        <span class="input-group-text">%</span>

                                    </div>
                                    <% if (request.getAttribute("error_pourcentageReduction") != null) { %>
                                    <span style="color: red;"><%= request.getAttribute("error_pourcentageReduction") %></span>
                                    <% } %>
                                    <div class="form-text">
                                        Réduction appliquée sur le prix du billet
                                    </div>
                                    <div class="invalid-feedback">
                                        Veuillez entrer un pourcentage valide entre 0 et 100
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-info mt-4">
                                <i class="bi bi-info-circle-fill me-2"></i>
                                <strong>Note:</strong> La promotion sera appliquée uniquement aux nouveaux billets
                                réservés après sa création.
                            </div>

                            <div class="d-flex gap-2 mt-4">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-1"></i>Enregistrer
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/promotions<%= selectedVol != null ? "?volId=" + selectedVol.getId() : "" %>"
                                   class="btn btn-secondary">
                                    <i class="bi bi-x-circle me-1"></i>Annuler
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/back-office/js/script.js"></script>
</body>
</html>