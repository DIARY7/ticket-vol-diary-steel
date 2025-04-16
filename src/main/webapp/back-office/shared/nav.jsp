<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
                        <a class="nav-link ${pageContext.request.servletPath.contains('/vols') ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/vols">
                            <i class="bi bi-airplane me-1"></i> Vols
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath.contains('/promotions') ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/promotions">
                            <i class="bi bi-tag me-1"></i> Promotions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath.contains('/parametres') ? 'active' : ''}"
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

    <!-- Bouton de changement de thème -->
    <button onclick="toggleTheme()" class="btn btn-custom-primary theme-switch">
        <i id="themeIcon" class="fas fa-moon"></i>
    </button>