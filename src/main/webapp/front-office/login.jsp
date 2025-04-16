<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <meta charset="UTF-8">
    <title>Connexion - Ticket Vol</title>
    <link href="${pageContext.request.contextPath}/assets/css/global.min.css" rel="stylesheet">
</head>

<body class="h-full">
<div
        class="min-h-screen flex items-center justify-center bg-gradient-to-tr from-blue-500 to-purple-600 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-white rounded-xl shadow-lg p-8">
        <div>
            <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                Connexion
            </h2>
            <p class="mt-2 text-center text-sm text-gray-600">
                Connectez-vous pour réserver vos vols
            </p>
        </div>

        <% if (request.getAttribute("error") != null){%>
            <div class="rounded-lg bg-red-50 p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd"
                                  d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                  clip-rule="evenodd"></path>
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-red-800"><%=request.getAttribute("error")%></p>
                    </div>
                </div>
            </div>
        <% } %>

        <form class="mt-8 space-y-6" action="${pageContext.request.contextPath}/login" method="post">
            <div class="space-y-4">
                <div>
                    <label for="username" class="block text-sm font-medium text-gray-700">
                        Nom d'utilisateur
                    </label>
                    <div class="mt-1">
                        <input id="username" name="pseudo" type="text" required class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-lg
                                shadow-sm placeholder-gray-400 focus:outline-none focus:ring-2 
                                focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">
                        Mot de passe
                    </label>
                    <div class="mt-1">
                        <input id="password" name="motDePasse" type="password" required class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-lg
                                shadow-sm placeholder-gray-400 focus:outline-none focus:ring-2 
                                focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                </div>
            </div>

            <div>
                <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-lg
                        shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 
                        focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 
                        transition-colors duration-200">
                    Se connecter
                </button>
            </div>
        </form>

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/"
               class="font-medium text-blue-600 hover:text-blue-500 transition-colors duration-200">
                Retour à l'accueil
            </a>
        </div>
    </div>
</div>
</body>

</html>