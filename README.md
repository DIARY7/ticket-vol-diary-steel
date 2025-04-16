# Ticket-vol - Flight Booking System POC

## Overview
This project is a proof of concept (POC) for a custom lightweight Java web framework implementation. It demonstrates a flight booking system built using a custom MVC framework that handles routing, controllers, database operations using Hibernate, and view management.

## Project Structure
```
ticket-vol/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/mg/
│   │   │       ├── controller/      # Controllers (back-office & front-office)
│   │   │       ├── dao/            # Data Access Objects
│   │   │       ├── DTO/            # Data Transfer Objects
│   │   │       ├── filter/         # Authentication filters
│   │   │       ├── model/          # Entity models
│   │   │       ├── service/        # Business logic services
│   │   │       └── utils/          # Utility classes
│   │   ├── resources/             # Configuration files
│   │   │   ├── hibernate.cfg.xml
│   │   │   └── script.sql
│   │   └── webapp/                # Web resources
│   │       ├── back-office/       # Admin interface
│   │       ├── front-office/      # User interface
│   │       └── WEB-INF/          # Web configuration
├── lib/                          # Custom framework & dependencies
└── pom.xml                      # Maven configuration
```

## Framework Features
- Custom MVC architecture
- Annotation-based routing
- Session management
- Role-based authentication
- Form validation
- Database integration with Hibernate

### Key Annotations
- `@Controller`: Marks a class as a controller
- `@Get/@Post`: Specifies HTTP method
- `@Url(road_url = "/path")`: Maps URLs to controller methods
- `@Param`: Binds request parameters to method arguments
- `@Auth`: Role-based access control

### Example Controller
```java
@Controller
public class AuthController {
    @Get
    @Url(road_url = "/login")
    public ModelAndView loginForm() {
        return new ModelAndView("/front-office/login.jsp");
    }

    @Post
    @Url(road_url = "/login")
    public ModelAndView processLogin(
        @Param(name = "pseudo") String username,
        @Param(name = "password") String password,
        CustomSession session
    ) {
        // Authentication logic
    }
}
```

### Session Management
CustomSession provides simplified session management:
```java
CustomSession session;
session.addSession("key", value);       // Set attribute
Object value = session.getAttribute("key"); // Get attribute
session.removeAttribute("key");         // Remove attribute
session.destroySession();               // Invalidate session
```

## Database Configuration
- PostgreSQL database
- Hibernate ORM for data persistence
- Configuration in hibernate.cfg.xml

## Project Setup
1. Configure PostgreSQL database
2. Update hibernate.cfg.xml with database credentials
3. Run script.sql to create database schema
4. Build with Maven:
   ```bash
   mvn clean package
   ```
5. Deploy WAR file to Tomcat

## Authentication
- Role-based access control (admin/user)
- Protected routes with @Auth annotation
- Session-based authentication

## Views
- JSP-based views
- Separate back-office and front-office interfaces
- Bootstrap for styling
- DataTables for data presentation
- Form validation (client & server-side)

## Deployment
Use deploy2.bat script for quick deployment to Tomcat:
```bash
deploy\deploy2.bat
```

## Framework Integration
Custom framework JAR (Framework.jar) provides:
- Route handling
- Controller management
- Session utilities
- Form processing
- View resolution

Framework source code available at: https://github.com/kenny516/FrameWork-Java-Web.git

## Dependencies
- Jakarta Servlet API 5.0.0
- Hibernate 5.6.15.Final
- PostgreSQL Driver
- GSON 2.8.9
- Custom Framework

## Testing
Access the application:
- Front-office: http://localhost:8080/ticket-vol/
- Back-office: http://localhost:8080/ticket-vol/back-office/

## Notes
- Built as a POC for custom Java web framework
- Uses custom annotations for routing and validation
- Simple JSP syntax preferred over JSTL
- Session management through CustomSession wrapper