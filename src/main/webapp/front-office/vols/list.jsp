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

<body class="bg-gray-50">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- En-tête de la page -->
    <div class="mb-8">
        <div class="flex justify-between items-center">
            <h1 class="text-2xl font-bold text-gray-900">
                Recherche de Vols</h1>
            <% Utilisateur user = (Utilisateur) session.getAttribute("user");
                if
                (user != null) { %>
            <div class="flex items-center space-x-4">
                <span class="text-gray-600">Bienvenue,
                    <%= user.getNom() %>
                </span>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Formulaire de recherche -->
    <div class="bg-white rounded-xl shadow-sm mb-6 p-6">
        <form action="<%= request.getContextPath() %>/vols/search"
              method="post">
            <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                <div class="space-y-2">
                    <label for="villeDepart"
                           class="block text-sm font-medium text-gray-700">
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
                           class="block text-sm font-medium text-gray-700">
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
                           class="block text-sm font-medium text-gray-700">
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
                    <button type="submit"
                            class="w-full px-3 py-2 text-sm font-medium text-white bg-blue-600 rounded-lg hover:bg-blue-700
                            focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors duration-200">
                        Rechercher
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Liste des vols -->
    <div class="bg-white rounded-xl shadow-sm overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Vol N°
                    </th>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Avion
                    </th>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Départ
                    </th>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Arrivée
                    </th>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Date
                    </th>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Prix
                    </th>
                    <th scope="col"
                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Actions
                    </th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <% for (Vol vol : vols) { %>
                <tr
                        class="hover:bg-gray-50 transition-colors duration-200">
                    <td
                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        <%= vol.getId() %>
                    </td>
                    <td
                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        <%= vol.getAvion().getModele() %>
                    </td>
                    <td
                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        <%= vol.getVilleDepart().getNom() %>
                    </td>
                    <td
                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        <%= vol.getVilleArrive().getNom() %>
                    </td>
                    <td
                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        <%= vol.getDateDepart() %>
                    </td>
                    <td class="px-6 py-4 text-sm text-gray-900">
                        <% for (PlaceVol placeVol : vol.getPlaceVols()) { %>
                        <div
                                class="flex items-center space-x-2 mb-1">
                                                                                <span
                                                                                        class="inline-flex items-center px-2.5 py-2 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                                                    <%= placeVol.getPlace().getTypeSiege().getDesignation()
                                                                                    %>
                                                                                </span>
                            <span>
                                                                                    <%= placeVol.getPrix() %>AR
                                                                                </span>
                        </div>
                        <% } %>
                    </td>
                    <td
                            class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        <a href="<%= request.getContextPath() %>/reserver?volId=<%= vol.getId() %>"
                           class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors duration-200">
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