<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Back Office - Gestion des Vols</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/back-office/css/style.css" rel="stylesheet">
        </head>

        <body>
            <!-- Barre de navigation fixe -->
            <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
                <div class="container">
                    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin">
                        <i class="bi bi-airplane-engines me-2"></i>
                        Administration
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/parametres">
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

            <!-- Contenu principal avec padding-top pour la navbar fixe -->
            <div class="container" style="margin-top: 5rem;">
                <div class="row mb-4">
                    <div class="col">
                        <h1 class="display-4 mb-4">Tableau de Bord</h1>
                    </div>
                </div>

                <!-- Cartes de statistiques -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="dashboard-stat primary">
                            <h3 class="mb-3"><i class="bi bi-airplane me-2"></i>Vols actifs</h3>
                            <h2 class="mb-0">${activeFlights}</h2>
                            <small>Vols programmés</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-stat success">
                            <h3 class="mb-3"><i class="bi bi-tag me-2"></i>Promotions</h3>
                            <h2 class="mb-0">${activePromotions}</h2>
                            <small>Promotions en cours</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="dashboard-stat warning">
                            <h3 class="mb-3"><i class="bi bi-people me-2"></i>Réservations</h3>
                            <h2 class="mb-0">${totalBookings}</h2>
                            <small>Total des réservations</small>
                        </div>
                    </div>
                </div>

                <!-- Actions rapides -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Actions rapides</h5>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <a href="${pageContext.request.contextPath}/admin/vols/create"
                                            class="btn btn-primary w-100 d-flex align-items-center justify-content-center">
                                            <i class="bi bi-plus-circle me-2"></i>
                                            Nouveau Vol
                                        </a>
                                    </div>
                                    <div class="col-md-4">
                                        <a href="${pageContext.request.contextPath}/admin/promotions/create"
                                            class="btn btn-success w-100 d-flex align-items-center justify-content-center">
                                            <i class="bi bi-tag me-2"></i>
                                            Nouvelle Promotion
                                        </a>
                                    </div>
                                    <div class="col-md-4">
                                        <a href="${pageContext.request.contextPath}/admin/parametres"
                                            class="btn btn-warning w-100 d-flex align-items-center justify-content-center">
                                            <i class="bi bi-gear me-2"></i>
                                            Paramètres Système
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sections des fonctionnalités -->
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="bi bi-airplane display-4 text-primary mb-3"></i>
                                <h5 class="card-title">Gestion des Vols</h5>
                                <p class="card-text">Gérez les vols, leurs horaires, prix et destinations.</p>
                                <a href="${pageContext.request.contextPath}/admin/vols" class="btn btn-outline-primary">
                                    Accéder aux vols
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="bi bi-tag display-4 text-success mb-3"></i>
                                <h5 class="card-title">Gestion des Promotions</h5>
                                <p class="card-text">Créez et gérez les promotions sur les vols.</p>
                                <a href="${pageContext.request.contextPath}/admin/promotions"
                                    class="btn btn-outline-success">
                                    Gérer les promotions
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="bi bi-gear display-4 text-warning mb-3"></i>
                                <h5 class="card-title">Paramètres Système</h5>
                                <p class="card-text">Configurez les délais de réservation et d'annulation.</p>
                                <a href="${pageContext.request.contextPath}/admin/parametres"
                                    class="btn btn-outline-warning">
                                    Configurer
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/back-office/js/script.js"></script>
        </body>

        </html>