<%@ page import="com.mg.model.Utilisateur" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/liste.css">
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
        <script>
            function toggleMobileMenu() {
                const mobileMenu = document.getElementById('mobileMenu');
                mobileMenu.classList.toggle('hidden');
            }
        </script>
        <nav class="neon-nav sticky top-0 z-50">
            <div class="container mx-auto px-4">
                <div class="flex justify-between items-center h-16">
                    <a href="${pageContext.request.contextPath}/vols/search"
                        class="flex items-center space-x-2 text-blue-600">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" viewBox="0 0 24 24" fill="currentColor">
                            <path
                                d="M21 16.5C21 16.88 20.79 17.21 20.47 17.38L12.57 21.82C12.41 21.94 12.21 22 12 22C11.79 22 11.59 21.94 11.43 21.82L3.53 17.38C3.21 17.21 3 16.88 3 16.5V7.5C3 7.12 3.21 6.79 3.53 6.62L11.43 2.18C11.59 2.06 11.79 2 12 2C12.21 2 12.41 2.06 12.57 2.18L20.47 6.62C20.79 6.79 21 7.12 21 7.5V16.5Z" />
                        </svg>
                        <span class="text-lg font-bold">Air Booking</span>
                    </a>

                    <div class="hidden md:flex items-center space-x-6">
                        <a href="${pageContext.request.contextPath}/vols/search"
                            class="px-3 py-2 rounded-lg  hover:bg-gray-100 hover:text-blue-600 transition-all duration-200">
                            Rechercher
                        </a>
                        <a href="${pageContext.request.contextPath}/mes-reservations"
                            class="px-3 py-2 rounded-lg  hover:bg-gray-100 hover:text-blue-600 transition-all duration-200">
                            Mes Réservations
                        </a>
                        <a href="${pageContext.request.contextPath}/profil"
                           class="px-3 py-2 rounded-lg  hover:bg-gray-100 hover:text-blue-600 transition-all duration-200">
                            Profil
                        </a>
                        <% if (session.getAttribute("user") !=null) { %>
                            <div class="flex items-center space-x-4 p-4">
                                <div class="flex gap-2 p-2 ">
                                    <img src="${pageContext.request.contextPath}/img/<%=((Utilisateur)session.getAttribute("user")).getPdp()%>" class="bg-red-500 w-8 h-8 rounded-full" alt="Avatar">
                                    <p class="text-white">
                                        <%=((Utilisateur)session.getAttribute("user")).getPseudo()%>
                                    </p>
                                </div>
                                <button>
                                    <a href="${pageContext.request.contextPath}/logout"
                                        class="" >
                                        Déconnexion
                                    </a>
                                </button>
                            </div>
                            <% } %>
                    </div>

                    <button class="md:hidden p-2 rounded-lg hover:bg-gray-100 transition-all duration-200"
                        onclick="toggleMobileMenu()" aria-label="Menu">
                        <svg class="w-6 h-6 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </button>
                </div>

                <!-- Menu mobile amélioré -->
                <div id="mobileMenu" class="md:hidden hidden transform transition-all duration-300 ease-in-out">
                    <div class="py-2 space-y-1">
                        <a href="${pageContext.request.contextPath}/vols/search"
                            class="block px-4 py-2 rounded-lg text-gray-700 hover:bg-gray-100 transition-all duration-200">
                            Rechercher
                        </a>
                        <a href="${pageContext.request.contextPath}/mes-reservations"
                            class="block px-4 py-2 rounded-lg text-gray-700 hover:bg-gray-100 transition-all duration-200">
                            Mes Réservations
                        </a>
                        <% if (session.getAttribute("user") !=null) { %>
                            <button>
                                <a href="${pageContext.request.contextPath}/logout"
                                class="block px-4 py-2 rounded-lg text-gray-700 hover:bg-gray-100 transition-all duration-200">
                                    Déconnexion
                                </a>
                            </button>
                            
                            <% } %>
                    </div>
                </div>
            </div>
        </nav>