<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.*" %>
        <%@ page import="com.mg.model.*" %>
            <%@ page import="java.text.SimpleDateFormat" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <title>Mes Réservations</title>
                    <jsp:include page="../shared/header.jsp" />
                </head>

                <body class="page-transition">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                        <div class="space-y-8">
                            <!-- En-tête -->
                            <div class="flex justify-between items-center">
                                <div>
                                    <h1 class="text-2xl font-bold text-white-900 dark:text-white">Mes Réservations</h1>
                                    <p class="mt-2 text-sm text-white-600 dark:text-gray-400">Gérez vos réservations de
                                        vols</p>
                                </div>
                                <a href="<%= request.getContextPath() %>/vols/search" class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm
                   font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 
                   focus:ring-offset-2 focus:ring-blue-500 transition-colors duration-200">
                                    <svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 4v16m8-8H4"></path>
                                    </svg>
                                    Rechercher un vol
                                </a>
                            </div>

                            <% String error=request.getParameter("error"); if (error !=null && !error.isEmpty()) { %>
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
                                    <% List<Reservation> reservations = (List<Reservation>)
                                            request.getAttribute("reservations");
                                            if (reservations == null || reservations.isEmpty()) { %>
                                            <div class="rounded-lg bg-blue-50 dark:bg-blue-900/50 p-8 text-center">
                                                <svg class="mx-auto h-12 w-12 text-blue-400" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                                    </path>
                                                </svg>
                                                <h3 class="mt-2 text-sm font-medium text-blue-800 dark:text-blue-200">
                                                    Aucune réservation</h3>
                                                <p class="mt-1 text-sm text-blue-600 dark:text-blue-400">Vous n'avez
                                                    aucune réservation en cours.</p>
                                            </div>
                                            <% } else { %>
                                                <div class="neon-card overflow-hidden">
                                                    <div class="overflow-x-auto">
                                                        <table class="min-w-full">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col">
                                                                        Vol
                                                                    </th>
                                                                    <th scope="col">
                                                                        Date
                                                                    </th>

                                                                    <th scope="col">
                                                                        Effectifs
                                                                    </th>

                                                                    <th scope="col">
                                                                        Type de siège
                                                                    </th>
                                                                    <th scope="col">
                                                                        Places
                                                                    </th>
                                                                    <th scope="col">
                                                                        Prix total
                                                                    </th>
                                                                    <th scope="col"
                                                                        class="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                                                                        Action
                                                                    </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody
                                                                class="divide-y">
                                                                <% SimpleDateFormat dateFormat=new
                                                                    SimpleDateFormat("dd/MM/yyyy HH:mm"); for
                                                                    (Reservation reservation : reservations) { String
                                                                    villeDepart=(reservation.getPlaceVol().getVol()
                                                                    !=null &&
                                                                    reservation.getPlaceVol().getVol().getVilleDepart()
                                                                    !=null) ?
                                                                    reservation.getPlaceVol().getVol().getVilleDepart().getNom()
                                                                    : "N/A" ; String
                                                                    villeArrive=(reservation.getPlaceVol().getVol()
                                                                    !=null &&
                                                                    reservation.getPlaceVol().getVol().getVilleArrive()
                                                                    !=null) ?
                                                                    reservation.getPlaceVol().getVol().getVilleArrive().getNom()
                                                                    : "N/A" ; String
                                                                    dateDepart=(reservation.getPlaceVol().getVol()
                                                                    !=null &&
                                                                    reservation.getPlaceVol().getVol().getDateDepart()
                                                                    !=null) ?
                                                                    dateFormat.format(reservation.getPlaceVol().getVol().getDateDepart())
                                                                    : "N/A" ; String
                                                                    typeSiege=(reservation.getPlaceVol().getPlace().getTypeSiege()
                                                                    !=null) ?
                                                                    reservation.getPlaceVol().getPlace().getTypeSiege().getDesignation()
                                                                    : "Non spécifié" ; int
                                                                    nombrePlaces=(reservation.getNombrePlaces() !=null)
                                                                    ? reservation.getNombrePlaces() : 0; double
                                                                    prixTotal=(reservation.getPrix() !=null) ?
                                                                    reservation.getPrix() : 0.0; boolean
                                                                    estValide=(reservation.getValider() !=null) &&
                                                                    reservation.getValider(); %>
                                                                    <tr>
                                                                        <td>
                                                                            <div class="flex items-center">
                                                                                <svg class="flex-shrink-0 h-5 w-5 text-white-400 dark:text-gray-500 mr-2"
                                                                                    xmlns="http://www.w3.org/2000/svg"
                                                                                    viewBox="0 0 20 20"
                                                                                    fill="currentColor">
                                                                                    <path
                                                                                        d="M3.105 2.289a.75.75 0 00-.826.95l1.414 4.925A1.5 1.5 0 005.135 9.25h6.115a.75.75 0 010 1.5H5.135a1.5 1.5 0 00-1.442 1.086l-1.414 4.926a.75.75 0 00.826.95 28.896 28.896 0 0015.293-7.154.75.75 0 000-1.115A28.897 28.897 0 003.105 2.289z">
                                                                                    </path>
                                                                                </svg>
                                                                                <%= villeDepart %> → <%= villeArrive %>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <%= dateDepart %>
                                                                        </td>
                                                                        <td>
                                                                            <div class="flex flex-col">
                                                                                <span>
                                                                                    <%= reservation.getNombreAdultes()
                                                                                        %> adulte(s)
                                                                                </span>
                                                                                <% if (reservation.getNombreEnfants()>
                                                                                    0) { %>
                                                                                    <span>
                                                                                        <%= reservation.getNombreEnfants()
                                                                                            %> enfant(s)
                                                                                    </span>
                                                                                    <% } %>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <span
                                                                                class="inline-flex items-center px-2.5 py-2 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-800 dark:text-blue-100">
                                                                                <%= typeSiege %>
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <%= nombrePlaces %>
                                                                        </td>
                                                                        <td>
                                                                            <%= prixTotal %> Ar
                                                                        </td>
                                                                        <td>
                                                                            <a href="http://localhost:8081/api/reservations/<%=reservation.getId()%>/pdf"
                                                                                class="inline-flex items-center px-3 py-1 border border-transparent rounded-md
                                                                                text-sm font-medium text-white bg-green-600 hover:bg-green-700 
                                                                                focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 
                                                                                transition-colors duration-200">
                                                                                <svg class="-ml-0.5 mr-2 h-4 w-4"
                                                                                    xmlns="http://www.w3.org/2000/svg"
                                                                                    fill="none" viewBox="0 0 24 24"
                                                                                    stroke="currentColor">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z">
                                                                                    </path>
                                                                                </svg>
                                                                                PDF
                                                                            </a>
                                                                            <a href="<%= request.getContextPath() %>/annuler-reservation?idReservation=<%=reservation.getId()%>"
                                                                                class="inline-flex items-center px-3 py-1 border border-transparent rounded-md
                                           text-sm font-medium text-white bg-red-600 hover:bg-red-700 
                                           focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 
                                           transition-colors duration-200">
                                                                                <svg class="-ml-0.5 mr-2 h-4 w-4"
                                                                                    xmlns="http://www.w3.org/2000/svg"
                                                                                    fill="none" viewBox="0 0 24 24"
                                                                                    stroke="currentColor">
                                                                                    <path stroke-linecap="round"
                                                                                        stroke-linejoin="round"
                                                                                        stroke-width="2"
                                                                                        d="M6 18L18 6M6 6l12 12"></path>
                                                                                </svg>
                                                                                Annuler
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <% } %>
                        </div>
                    </div>
                </body>

                </html>