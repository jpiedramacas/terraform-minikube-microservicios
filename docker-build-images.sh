# Configurar Docker para usar el demonio de Docker de Minikube
eval $(minikube -p minikube docker-env)

# Obtener la IP de Minikube
MINIKUBE_IP=$(minikube ip)

# Construir las imágenes
docker build --tag ${MINIKUBE_IP}:5000/php-webserver -f ./dockerfiles/Dockerfile.apache .
docker build --tag ${MINIKUBE_IP}:5000/phpmyadmin -f ./dockerfiles/Dockerfile.phpmyadmin .
docker build --tag ${MINIKUBE_IP}:5000/mysql -f ./dockerfiles/Dockerfile.mysql .

# Habilitar el registro en Minikube
minikube addons enable registry

# Subir las imágenes al registro local
docker push ${MINIKUBE_IP}:5000/php-webserver
docker push ${MINIKUBE_IP}:5000/phpmyadmin
docker push ${MINIKUBE_IP}:5000/mysql
