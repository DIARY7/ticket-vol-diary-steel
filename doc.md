# Documentation du Framework Web Java

## Les Annotations

### @Controller
Pour déclarer une classe comme contrôleur :
```java
@Controller 
public class MonController {
    // Méthodes du contrôleur
}
```

### @Get et @Post
Pour spécifier la méthode HTTP à utiliser sur une action :
```java
@Get  // Pour les requêtes GET
@Post // Pour les requêtes POST
```

### @Url 
Pour définir l'URL qui déclenchera la méthode :
```java
@Url(road_url = "/ma-route")
```

### @Param
Pour récupérer les paramètres de la requête :
```java
@Param(name = "nomParametre") String valeur
```

## Gestion des Sessions avec CustomSession

La classe CustomSession permet de gérer la session HTTP :

```java
public class CustomSession {
    private HttpSession httpSession;
    
    // Constructeurs
    public CustomSession(HttpSession httpSession)
    public CustomSession()
    
    // Méthodes
    public void addSession(String key, Object value)      // Ajoute une donnée en session
    public Object getAttribute(String key)                // Récupère une donnée de la session
    public void removeAttribute(String key)              // Supprime une donnée de la session
    public void destroySession()                         // Détruit la session
}
```

Pour utiliser la session dans un contrôleur, ajoutez simplement CustomSession comme paramètre :
```java
public ModelAndView maMethode(CustomSession session) {
    // Utilisation de la session
}
```

## ModelAndView

La classe ModelAndView gère le retour des vues et le transfert de données :

### Méthodes principales :
- `setUrl(String url)` : Définit l'URL de destination
- `setIsRedirect(boolean)` : Active/désactive la redirection (status 302)
- `add_data(String key, Object value)` : Ajoute des données pour la vue

### Exemple d'utilisation :
```java
ModelAndView mv = new ModelAndView("/maVue.jsp");
mv.add_data("maClé", "maValeur");
mv.setIsRedirect(true);
return mv;
```

## Exemple Complet d'un Contrôleur

```java
@Controller
public class AuthController {
    private final UtilisateurService userService;
    
    public AuthController() {
        this.userService = new UtilisateurService();
    }

    @Get
    @Url(road_url = "/loginForm")
    public ModelAndView loginForm() {
        return new ModelAndView("/login.jsp");
    }

    @Post
    @Url(road_url = "/login")
    public ModelAndView login(
            @Param(name = "pseudo") String pseudo,
            @Param(name = "motDePasse") String motDePasse,
            CustomSession session) {
            
        ModelAndView mv = new ModelAndView();
        Utilisateur user = userService.login(pseudo, motDePasse);
        
        if (user != null) {
            session.addSession("user", user);
            mv.setUrl("/dashboard");
            mv.setIsRedirect(true);
        } else {
            mv.setUrl("/login.jsp");
            mv.add_data("error", "Identifiants invalides");
        }
        
        return mv;
    }
}
```

## Utilisation dans les JSP

Les données envoyées via ModelAndView sont accessibles dans les JSP avec la syntaxe standard :

```jsp
<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <div class="error"><%= error %></div>
<%
    }
%>
```

## Points Importants
- Les annotations sont obligatoires pour le routage (@Controller, @Get/@Post, @Url)
- CustomSession donne accès à la session HTTP
- ModelAndView gère le retour des vues et le transfert de données
- Utiliser la syntaxe JSP standard plutôt que JSTL
- Les paramètres sont récupérés avec @Param