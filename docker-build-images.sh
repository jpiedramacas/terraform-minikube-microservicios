#!/bin/bash

# Configurar Docker para usar el demonio de Docker de Minikube
eval $(minikube -p minikube docker-env)

# Navegar al directorio raíz del proyecto
cd ..

# Construir la imagen del servidor web PHP
docker build --tag $(minikube ip):5000/php-webserver -f Dockerfile .
