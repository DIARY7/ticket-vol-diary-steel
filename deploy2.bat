@echo off
setlocal enabledelayedexpansion

REM Configuration Tomcat
set "TOMCAT_HOME=D:\Etudes\serveur\tomcat10"
set "TOMCAT_WEBAPPS=%TOMCAT_HOME%\webapps"

echo Building with Maven...
call mvn clean package

if errorlevel 1 (
    echo Erreur lors de la compilation Maven
    pause
    exit /b 1
)

echo Deploying to Tomcat...
if exist "%TOMCAT_WEBAPPS%\ticket-vol" (
    rmdir /s /q "%TOMCAT_WEBAPPS%\ticket-vol"
)
if exist "%TOMCAT_WEBAPPS%\ticket-vol.war" (
    del /f /q "%TOMCAT_WEBAPPS%\ticket-vol.war"
)

copy /y "target\ticket-vol.war" "%TOMCAT_WEBAPPS%\ticket-vol.war"

echo Deployment completed successfully.
echo `(^^_^^)`
pause