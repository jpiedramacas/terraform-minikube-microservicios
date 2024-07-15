#!/bin/bash

# Configure Docker to use the Minikube Docker daemon
eval $(minikube -p minikube docker-env)

# Obtain the IP of Minikube
MINIKUBE_IP=$(minikube ip)

# Enable the registry addon in Minikube
minikube addons enable registry

# Build the images and tag them with Minikube's IP
docker build --tag ${MINIKUBE_IP}:5000/php-webserver -f ./dockerfiles/Dockerfile.apache .
docker build --tag ${MINIKUBE_IP}:5000/phpmyadmin -f ./dockerfiles/Dockerfile.phpmyadmin .
docker build --tag ${MINIKUBE_IP}:5000/mysql -f ./dockerfiles/Dockerfile.mysql .
