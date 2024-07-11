#!/bin/bash

# Configurar Docker para usar el demonio de Docker de Minikube
eval $(minikube -p minikube docker-env)

# Construir la imagen del servidor web PHP
docker build --tag $(minikube ip):5000/php-webserver -f Dockerfile .

# Construir la imagen de phpMyAdmin
docker build --tag $(minikube ip):5000/phpmyadmin -f Dockerfile.phpmyadmin .
