<%@ page import="com.mg.model.Utilisateur" %><%--
  Created by IntelliJ IDEA.
  User: kenny
  Date: 19/02/2025
  Time: 13:45
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile Details</title>
    <jsp:include page="shared/header.jsp"/>
    <%
        Utilisateur utilisateurActuel = (Utilisateur) request.getAttribute("utilisateur");

    %>
</head>
<body>
<div class="m-auto border border-blue-400 mt-20 w-full max-w-md bg-white rounded-2xl shadow-lg p-8 transition-all duration-300 hover:shadow-xl">
    <!-- Profile Header -->
    <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-2">Profile Details</h1>
        <div class="h-1 w-20 bg-blue-500 rounded-full mx-auto"></div>
    </div>

    <!-- Profile Content -->
    <div class="space-y-6">
        <!-- Profile Image -->
        <div class="flex justify-center">
            <div class="relative w-32 h-32 rounded-xl bg-gradient-to-r from-blue-400 to-purple-500
            shadow-md flex items-center justify-center overflow-hidden">
                <!-- Profile Picture -->
                <img id="profile-picture"
                     src="${pageContext.request.contextPath}/img/<%=((Utilisateur)session.getAttribute("user")).getPdp()%>"
                     alt="Profile Picture"
                     class="w-full h-full object-cover <%=utilisateurActuel.getPdp() == null ? "hidden" : ""%>"
                     onerror="this.classList.add('hidden'); document.getElementById('profile-initial').classList.remove('hidden');">
                <span id="profile-initial"
                      class="text-white text-4xl font-bold <%=utilisateurActuel.getPdp() != null ? "hidden" : ""%>">
          <%=utilisateurActuel.getPrenom().substring(0, 1).toUpperCase()%>
                </span>
            </div>

        </div>
        <form id="upload-form" action="uploadProfilePicture" method="post" enctype="multipart/form-data"
              class="flex justify-center mt-2">
            <!-- L'input est caché, mais placé avant son label -->
            <input id="file-input" type="file" name="profilePicture" accept="image/*" class="hidden"
                   onchange="previewImage(event)">
            <label for="file-input"
                   class="cursor-pointer bg-blue-500 h-5 w-5 flex item-center text-white shadow-md hover:bg-blue-600 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd"
                          d="M4 5a2 2 0 00-2 2v8a2 2 0 002 2h12a2 2 0 002-2V7a2 2 0 00-2-2h-1.586a1 1 0 01-.707-.293l-1.121-1.121A2 2 0 0011.172 3H8.828a2 2 0 00-1.414.586L6.293 4.707A1 1 0 015.586 5H4zm6 9a3 3 0 100-6 3 3 0 000 6z"
                          clip-rule="evenodd"></path>
                </svg>
            </label>
        </form>

        <!-- Profile Details -->
        <div class="space-y-4">
            <div class="bg-gray-50 p-4 rounded-lg">
                <label class="text-sm font-medium text-gray-500 block mb-1">Pseudo</label>
                <p class="text-gray-800 font-semibold"><%=utilisateurActuel.getPseudo()%>
                </p>
            </div>

            <div class="bg-gray-50 p-4 rounded-lg">
                <label class="text-sm font-medium text-gray-500 block mb-1">Nom</label>
                <p class="text-gray-800 font-semibold"><%=utilisateurActuel.getNom()%>
                </p>
            </div>

            <div class="bg-gray-50 p-4 rounded-lg">
                <label class="text-sm font-medium text-gray-500 block mb-1">Prenom</label>
                <p class="text-gray-800 font-semibold"><%=utilisateurActuel.getPrenom()%>
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    function previewImage(event) {
        const fileInput = event.target;
        const profilePicture = document.getElementById('profile-picture');
        const profileInitial = document.getElementById('profile-initial');

        if (fileInput.files && fileInput.files[0]) {
            const reader = new FileReader();

            reader.onload = function (e) {
                profilePicture.src = e.target.result;
                profilePicture.classList.remove('hidden');
                profileInitial.classList.add('hidden');
                // Soumettre le formulaire automatiquement après la sélection de la photo
                document.getElementById('upload-form').submit();
            };

            reader.readAsDataURL(fileInput.files[0]);
        }
    }
</script>
</body>
</html>
