<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Erreur serveur - 500</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .error-template {
                padding: 40px 15px;
                text-align: center;
            }

            .error-actions {
                margin-top: 15px;
                margin-bottom: 15px;
            }

            .error-actions .btn {
                margin-right: 10px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="error-template">
                        <h1>Oops!</h1>
                        <h2>500 - Erreur serveur</h2>
                        <div class="error-details">
                            Désolé, une erreur s'est produite lors du traitement de votre demande.
                            Notre équipe technique a été notifiée et travaille à résoudre le problème.
                        </div>
                        <div class="error-actions">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="bi bi-house"></i> Retour à l'accueil
                            </a>
                            <a href="javascript:history.back()" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Page précédente
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>