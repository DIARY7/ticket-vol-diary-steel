<%@ page import="com.mg.model.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html class="h-full bg-gray-50 dark:bg-gray-900">

        <head>
            <title>Réserver un vol</title>
            <jsp:include page="../shared/header.jsp" />
        </head>

        <body class="h-full">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                <div class="space-y-8">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Réservation de vol</h1>
                        <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">Complétez les informations ci-dessous
                            pour réserver
                            votre vol</p>
                    </div>

                    <% String error=(String) request.getAttribute("error"); if (error !=null && !error.isEmpty()) { %>
                        <div class="rounded-lg bg-red-50 dark:bg-red-900/50 p-4">
                            <div class="flex">
                                <div class="flex-shrink-0">
                                    <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd"
                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                            clip-rule="evenodd"></path>
                                    </svg>
                                </div>
                                <div class="ml-3">
                                    <p class="text-sm font-medium text-red-800 dark:text-red-200">
                                        <%= error %>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <% } %>
                            <% Vol vol=(Vol) request.getAttribute("vol"); if (vol !=null) { %>
                                <!-- Détails du vol -->
                                <div class="bg-white dark:bg-gray-800 shadow-sm rounded-xl overflow-hidden">
                                    <div class="px-6 py-5">
                                        <h3 class="text-lg font-medium text-gray-900 dark:text-white mb-4">Détails du
                                            vol</h3>
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div class="space-y-3">
                                                <div>
                                                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                                        Départ</p>
                                                    <p class="mt-1 text-base text-gray-900 dark:text-white">
                                                        <%= vol.getVilleDepart().getNom() %>
                                                    </p>
                                                </div>
                                                <div>
                                                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                                        Arrivée</p>
                                                    <p class="mt-1 text-base text-gray-900 dark:text-white">
                                                        <%= vol.getVilleArrive().getNom() %>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="space-y-3">
                                                <div>
                                                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Date
                                                        et heure</p>
                                                    <p class="mt-1 text-base text-gray-900 dark:text-white">
                                                        <%= new
                                                            java.text.SimpleDateFormat("dd/MM/yyyyHH:mm").format(vol.getDateDepart())
                                                            %>
                                                    </p>
                                                </div>
                                                <div>
                                                    <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                                        Tarifs</p>
                                                    <div class="mt-1 space-y-1">
                                                        <% for (PlaceVol placeVol : vol.getPlaceVols()) { %>
                                                            <div class="flex items-center space-x-2">
                                                                <span
                                                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-800 dark:text-blue-100">
                                                                    <%= placeVol.getPlace().getTypeSiege().getDesignation() %>
                                                                </span>
                                                                <span class="text-gray-900 dark:text-white">
                                                                    <%= placeVol.getPrix() %> AR
                                                                </span>
                                                            </div>
                                                            <% } %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Formulaire de réservation -->
                                <form action="<%= request.getContextPath() %>/vols/reserver" method="post"
                                    class="space-y-6">
                                    <input type="hidden" name="volId" value="<%= vol.getId() %>">

                                    <div class="bg-white dark:bg-gray-800 shadow-sm rounded-xl overflow-hidden">
                                        <div class="px-6 py-5 space-y-6">
                                            <div>
                                                <label for="typeSiegeId"
                                                    class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                                                    Type de siège
                                                </label>
                                                <select name="typeSiegeId" id="typeSiegeId" required class="mt-1 block w-full pl-3 pr-10 py-2 text-base  border border-gray-500 focus:outline-none
                                    focus:ring-blue-500 focus:border-blue-500 rounded-lg dark:bg-gray-700 
                                    dark:border-gray-600 dark:text-white sm:text-sm">
                                                    <option value="">Sélectionnez un type de siège</option>
                                                    <% for (PlaceVol placeVol : vol.getPlaceVols()) { %>
                                                        <option value="<%= placeVol.getPlace().getTypeSiege().getId() %>">
                                                            <%= placeVol.getPlace().getTypeSiege().getDesignation() %>
                                                        </option>
                                                        <% } %>
                                                </select>
                                            </div>

                                            <div>
                                                <label for="nombreAdultes"
                                                    class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                                                    Nombre d'adultes
                                                </label>
                                                <input type="number" name="nombreAdultes" id="nombreAdultes" min="0"
                                                    value="1" required class="mt-1 block w-full px-3 py-2 border border-gray-500 rounded-lg shadow-sm
                                    focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 
                                    dark:border-gray-600 dark:text-white sm:text-sm">
                                            </div>

                                            <div>
                                                <label for="nombreEnfants"
                                                    class="block text-sm font-medium text-gray-700 dark:text-gray-300">
                                                    Nombre d'enfants
                                                </label>
                                                <input type="number" name="nombreEnfants" id="nombreEnfants" min="0"
                                                    value="0" required class="mt-1 block w-full px-3 py-2 border border-gray-500 rounded-lg shadow-sm
                                    focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 
                                    dark:border-gray-600 dark:text-white sm:text-sm">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flex items-center space-x-4">
                                        <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent rounded-lg shadow-sm
                            text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 
                            focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 
                            transition-colors duration-200">
                                            Confirmer la réservation
                                        </button>
                                        <a href="<%= request.getContextPath() %>/vols/search" class="inline-flex justify-center py-2 px-4 border border-gray-300 rounded-lg shadow-sm
                            text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 
                            focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 
                            dark:bg-gray-700 dark:text-gray-300 dark:border-gray-600 dark:hover:bg-gray-600 
                            transition-colors duration-200">
                                            Retour
                                        </a>
                                    </div>
                                </form>
                                <script>
                                    document.querySelector('form').addEventListener('submit', function (e) {
                                        const nombreAdultes = parseInt(document.getElementById('nombreAdultes').value) || 0;
                                        const nombreEnfants = parseInt(document.getElementById('nombreEnfants').value) || 0;

                                        if (nombreAdultes + nombreEnfants === 0) {
                                            e.preventDefault();
                                            alert('Le nombre total de passagers doit être supérieur à 0');
                                        }
                                    });
                                </script>
                                <% } %>
                </div>
            </div>
        </body>

        </html>