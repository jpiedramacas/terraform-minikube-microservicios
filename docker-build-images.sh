#!/bin/bash

# Configurar Docker para usar el demonio de Docker de Minikube
eval $(minikube -p minikube docker-env)

# Construir la imagen del servidor web PHP
docker build --tag $(minikube ip):5000/php-webserver -f ./dockerfiles/Dockerfile.apache .

# Construir la imagen de phpMyAdmin
docker build --tag $(minikube ip):5000/phpmyadmin -f ./dockerfiles/Dockerfile.phpmyadmin .

# Construir la imagen de MySQL
docker build --tag $(minikube ip):5000/mysql -f ./dockerfiles/Dockerfile.mysql .
