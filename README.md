
### Paso 1: Iniciar Minikube

1. **Iniciar Minikube**:
   ```bash
   minikube start
   ```

2. **Configurar Docker para usar el demonio de Docker de Minikube**:
   ```bash
   eval $(minikube -p minikube docker-env)
   ```

### Paso 2: Construir la Imagen Docker

1. **Navegar al directorio del proyecto**:
   ```bash
   cd ~/GIT/terraform-minikube-microservicios
   ```

2. **Ejecutar el script para construir la imagen Docker**:
   ```bash
   ./docker-build-images.sh
   ```

   Este script configurará Docker para usar el demonio de Docker de Minikube y construirá la imagen del servidor web PHP.

### Paso 3: Configurar Terraform

1. **Inicializar Terraform**:
   ```bash
   cd ~/GIT/terraform-minikube-microservicios
   terraform init
   ```

   Esto descargará los proveedores necesarios y configurará el entorno de Terraform.

2. **Aplicar la configuración de Terraform**:
   ```bash
   terraform apply
   ```

   Terraform te pedirá confirmación para aplicar los cambios. Escribe `yes` y presiona Enter.

### Paso 4: Verificar el Despliegue

1. **Obtener la lista de pods en el clúster de Kubernetes**:
   ```bash
   kubectl get pods
   ```

   Deberías ver los pods creados por los despliegues de Apache y phpMyAdmin.

2. **Obtener la lista de servicios en el clúster de Kubernetes**:
   ```bash
   kubectl get services
   ```

   Aquí deberías ver los servicios creados, incluyendo el servicio de Apache y el de phpMyAdmin.

3. **Acceder a la aplicación PHP web**:
   - Obtén el puerto asignado al servicio de Apache:
     ```bash
     kubectl get service php-webserver-service
     ```
     Busca el puerto asignado en la columna `PORT(S)` (por ejemplo, `30000:80/TCP`).

   - Accede a la aplicación en tu navegador usando la IP de Minikube y el puerto asignado. Obtén la IP de Minikube:
     ```bash
     minikube ip
     ```
     Si la IP es `192.168.99.100` y el puerto es `30000`, abre `http://192.168.99.100:30000` en tu navegador.

4. **Acceder a phpMyAdmin**:
   - Obtén el puerto asignado al servicio de phpMyAdmin:
     ```bash
     kubectl get service phpmyadmin-service
     ```
     Busca el puerto asignado en la columna `PORT(S)` (por ejemplo, `30001:80/TCP`).

   - Accede a phpMyAdmin en tu navegador usando la IP de Minikube y el puerto asignado. Si la IP de Minikube es `192.168.99.100` y el puerto es `30001`, abre `http://192.168.99.100:30001` en tu navegador.


