<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Ticket Vol</title>
    <link href="${pageContext.request.contextPath}/assets/css/global.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/login.css" rel="stylesheet">
</head>

<body>
<div class="login-container">
    <!-- Neon grid background -->
    <div class="neon-grid"></div>
    
    <!-- Neon lines -->
    <div class="neon-lines" id="neonLines"></div>
    
    <!-- Glowing particles -->
    <div class="particles" id="particles"></div>
    
    <div class="login-card">
        <div class="card-header">
            <h2 class="login-title">Connexion</h2>
            <p class="login-subtitle">Accédez à votre espace de réservation</p>
            <div class="neon-border"></div>
        </div>

        <div class="card-body">
            <% if (request.getAttribute("error") != null){%>
                <div class="error-message">
                    <svg class="error-icon" width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd"
                              d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                              clip-rule="evenodd"></path>
                    </svg>
                    <p class="error-text"><%=request.getAttribute("error")%></p>
                </div>
            <% } %>

            <form id="loginForm" class="login-form" action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username" class="form-label">Identifiant</label>
                    <div class="input-wrapper">
                        <input id="username" name="pseudo" type="text" required class="form-input" autocomplete="username">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Mot de passe</label>
                    <div class="input-wrapper">
                        <input id="password" name="motDePasse" type="password" required class="form-input" autocomplete="current-password">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </div>
                </div>

                <button type="submit" class="submit-btn neon-flicker">
                    Se connecter
                </button>
                
                <div class="loading">
                    <div class="loading-spinner"></div>
                </div>
            </form>

            <div class="home-link-container">
                <a href="${pageContext.request.contextPath}/" class="home-link">
                    <svg class="home-link-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                        <polyline points="9 22 9 12 15 12 15 22"></polyline>
                    </svg>
                    Retour à l'accueil
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loginForm = document.getElementById('loginForm');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const loadingElement = document.querySelector('.loading');
        const neonLines = document.getElementById('neonLines');
        const particles = document.getElementById('particles');
        
        // Create neon lines
        function createNeonLines() {
            for (let i = 0; i < 8; i++) {
                const line = document.createElement('div');
                line.classList.add('neon-line');
                
                // Random position and width
                line.style.top = `${Math.random() * 100}%`;
                line.style.width = `${Math.random() * 30 + 20}%`;
                line.style.left = `${Math.random() * 70}%`;
                
                // Random animation duration and delay
                const duration = Math.random() * 5 + 5;
                const delay = Math.random() * 8;
                line.style.animationDuration = `${duration}s`;
                line.style.animationDelay = `${delay}s`;
                
                neonLines.appendChild(line);
            }
        }
        
        // Create glowing particles
        function createParticles() {
            const colors = [
                'var(--neon-blue)',
                'var(--neon-purple)',
                'var(--neon-pink)',
                'var(--neon-green)'
            ];
            
            for (let i = 0; i < 40; i++) {
                const particle = document.createElement('div');
                particle.classList.add('particle');
                
                // Random color
                const colorIndex = Math.floor(Math.random() * colors.length);
                particle.style.color = colors[colorIndex];
                
                // Random position
                particle.style.left = `${Math.random() * 100}%`;
                
                // Random size
                const size = Math.random() * 3 + 1;
                particle.style.width = `${size}px`;
                particle.style.height = `${size}px`;
                
                // Random animation
                const duration = Math.random() * 10 + 10;
                const delay = Math.random() * 10;
                particle.style.animationDuration = `${duration}s`;
                particle.style.animationDelay = `${delay}s`;
                
                particles.appendChild(particle);
            }
        }
        
        // Form validation
        loginForm.addEventListener('submit', function(e) {
            let isValid = true;
            
            // Simple validation
            if (!usernameInput.value.trim()) {
                usernameInput.classList.add('error');
                isValid = false;
            } else {
                usernameInput.classList.remove('error');
            }
            
            if (!passwordInput.value.trim()) {
                passwordInput.classList.add('error');
                isValid = false;
            } else {
                passwordInput.classList.remove('error');
            }
            
            if (isValid) {
                // Show loading animation
                loadingElement.classList.add('active');
                
                // Allow form submission
                return true;
            } else {
                e.preventDefault();
                // Shake effect for form on error
                loginForm.animate([
                    { transform: 'translateX(0)' },
                    { transform: 'translateX(-10px)' },
                    { transform: 'translateX(10px)' },
                    { transform: 'translateX(-10px)' },
                    { transform: 'translateX(10px)' },
                    { transform: 'translateX(0)' }
                ], {
                    duration: 500,
                    easing: 'cubic-bezier(.36,.07,.19,.97)'
                });
                return false;
            }
        });
        
        // Input focus effects with neon glow
        const inputs = document.querySelectorAll('.form-input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.boxShadow = `0 0 15px rgba(0, 243, 255, 0.7), 0 0 30px rgba(0, 243, 255, 0.4)`;
            });
            
            input.addEventListener('blur', function() {
                if (!this.classList.contains('error')) {
                    this.style.boxShadow = '';
                }
            });
        });
        
        // Initialize neon effects
        createNeonLines();
        createParticles();
        
        // Add interactive neon effect on mouse move
        document.addEventListener('mousemove', function(e) {
            const mouseX = e.clientX / window.innerWidth;
            const mouseY = e.clientY / window.innerHeight;
            
            // Adjust grid perspective based on mouse position
            const grid = document.querySelector('.neon-grid');
            grid.style.transform = `perspective(500px) rotateX(${60 + mouseY * 5}deg) rotateY(${mouseX * 5 - 2.5}deg)`;
            
            // Create dynamic neon line on mouse move (occasionally)
            if (Math.random() < 0.03) {
                const line = document.createElement('div');
                line.classList.add('neon-line');
                line.style.top = `${e.clientY}px`;
                line.style.width = `${Math.random() * 30 + 20}%`;
                line.style.left = `${e.clientX / window.innerWidth * 70}%`;
                line.style.animationDuration = `${Math.random() * 3 + 3}s`;
                line.style.opacity = '0.7';
                
                neonLines.appendChild(line);
                
                // Remove after animation completes
                setTimeout(() => {
                    neonLines.removeChild(line);
                }, 6000);
            }
        });
        
        // Add neon flicker effect to random elements
        function addRandomFlicker() {
            const elements = [
                document.querySelector('.login-card'),
                document.querySelector('.neon-border'),
                ...document.querySelectorAll('.form-input')
            ];
            
            const randomElement = elements[Math.floor(Math.random() * elements.length)];
            randomElement.classList.add('neon-flicker');
            
            setTimeout(() => {
                randomElement.classList.remove('neon-flicker');
            }, 5000);
            
            // Schedule next flicker
            setTimeout(addRandomFlicker, Math.random() * 10000 + 5000);
        }
        
        // Start random flicker effect
        setTimeout(addRandomFlicker, 3000);
    });
</script>
</body>
</html>