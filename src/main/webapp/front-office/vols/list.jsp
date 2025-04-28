<%@ page import="java.util.List" %>
<%@ page import="com.mg.model.*" %>
<%@ page import="com.mg.DTO.VolDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    Integer villeDepartId = (request.getAttribute("villeDepartId") != null) ? (Integer)
            request.getAttribute("villeDepartId") : null;
    Integer villeArriveId = (request.getAttribute("villeArriveId") != null) ? (Integer)
            request.getAttribute("villeArriveId") : null;
    String dateDepart = (request.getAttribute("dateDepart") != null) ? (String)
            request.getAttribute("dateDepart") : "";
    Double maxPrice = (request.getAttribute("maxPrice") != null) ? (Double)
            request.getAttribute("maxPrice") : null;
%>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Vols</title>
    <jsp:include page="../shared/header.jsp"/>
</head>

<body class="page-transition">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- En-tête de la page -->
    <div class="mb-8">
        <div class="flex justify-between items-center">
            <h1 class="text-2xl font-bold text-white-900">
                Recherche de Vols</h1>
            <% Utilisateur user = (Utilisateur) session.getAttribute("user");
                if
                (user != null) { %>
            <div class="flex items-center space-x-4">
                <span class="text-white-600">Bienvenue,
                    <%= user.getNom() %>
                </span>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Formulaire de recherche -->
    <div class="neon-card mb-6 p-6">
        <form action="<%= request.getContextPath() %>/vols/search"
              method="post">
            <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                <div class="space-y-2">
                    <label for="villeDepart"
                           class="block text-sm font-medium text-white-700">
                        Ville de départ
                    </label>
                    <select name="villeDepart" id="villeDepart"
                            class="text-black px-3 py-2 block w-full rounded-lg border border-gray-300 bg-gray-50 focus:border-blue-500 focus:ring-blue-500 text-sm">
                        <option value="">Tous</option>
                        <% for (Ville ville : villes) { %>
                        <option value="<%= ville.getId() %>"
                                <%=(ville.getId().equals(villeDepartId))
                                        ? "selected" : "" %>>
                            <%= ville.getNom() %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="space-y-2">
                    <label for="villeArrive"
                           class="block text-sm font-medium text-white-700">
                        Ville d'arrivée
                    </label>
                    <select name="villeArrive" id="villeArrive"
                            class="text-black px-3 py-2 block w-full rounded-lg border border-gray-300 bg-gray-50 focus:border-blue-500 focus:ring-blue-500 text-sm">
                        <option value="">Tous</option>
                        <% for (Ville ville : villes) { %>
                        <option value="<%= ville.getId() %>"
                                <%=(ville.getId().equals(villeArriveId))
                                        ? "selected" : "" %>>
                            <%= ville.getNom() %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="space-y-2">
                    <label for="dateDepart"
                           class="block text-sm font-medium text-white-700">
                        Date de départ
                    </label>
                    <input type="date" name="dateDepart" id="dateDepart"
                           value="<%=dateDepart %>" class="text-black px-3 py-2 block w-full rounded-lg border border-gray-300 bg-gray-50
                            focus:border-blue-500 focus:ring-blue-500 text-sm">
                </div>

                <!-- <div class="space-y-2">
                    <label for="maxPrice"
                           class="block text-sm font-medium text-gray-700">
                        Prix maximum
                    </label>
                    <input type="number" name="maxPrice" id="maxPrice"
                           value="<%=maxPrice%>" class="text-black px-3 py-2 block w-full rounded-lg border border-gray-300 bg-gray-50
                            focus:border-blue-500 focus:ring-blue-500 text-sm">
                </div> -->

                <div class="flex items-end">
                    <button type="submit">
                        Rechercher
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Liste des vols -->
    <div class="neon-card overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full">
                <thead>
                <tr>
                    <th>
                        Vol N°
                    </th>
                    <th>
                        Avion
                    </th>
                    <th>
                        Départ
                    </th>
                    <th>
                        Arrivée
                    </th>
                    <th>
                        Date
                    </th>
                    <th>
                        Prix
                    </th>
                    <th>
                        Actions
                    </th>
                </tr>
                </thead>
                <tbody>
                <% for (Vol vol : vols) { %>
                <tr>
                    <td class="whitespace-nowrap">
                        <%= vol.getId() %>
                    </td>
                    <td class="whitespace-nowrap">
                        <%= vol.getAvion().getModele() %>
                    </td>
                    <td class="whitespace-nowrap">
                        <%= vol.getVilleDepart().getNom() %>
                    </td>
                    <td class="whitespace-nowrap">
                        <%= vol.getVilleArrive().getNom() %>
                    </td>
                    <td class="whitespace-nowrap">
                        <%= vol.getDateDepart() %>
                    </td>
                    <td>
                        <% for (PlaceVol placeVol : vol.getPlaceVols()) { %>
                        <div class="flex items-center space-x-2 mb-1">
                            <span class="inline-flex">
                                <%= placeVol.getPlace().getTypeSiege().getDesignation() %>
                            </span>
                            <span>
                                <%= placeVol.getPrix() %>AR
                            </span>
                        </div>
                        <% } %>
                    </td>
                    <td class="whitespace-nowrap">
                        <a href="<%= request.getContextPath() %>/reserver?volId=<%= vol.getId() %>"
                           class="reservation-btn">
                            Réserver
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>

</html>