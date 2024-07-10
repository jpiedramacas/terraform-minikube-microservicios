#!/bin/bash

# Set up Docker to use Minikube's Docker daemon
eval $(minikube -p minikube docker-env)

# Navigate to the project root directory
cd ..

# Build the PHP web server image
docker build --tag $(minikube ip):5000/php-webserver -f php/Dockerfile .