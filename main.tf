terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

locals {
  minikube_ip = "192.168.49.2"  # Asegúrate de que esta IP sea la correcta para tu Minikube
}

module "phpmyadmin" {
  source    = "./phpMyAdmin"
  namespace = "default"
  app_name  = "phpmyadmin"
  replicas  = 1
  image     = "phpmyadmin:latest"
  mysql_host  = "mysql-service"  # Asegúrate de que este valor coincida con el nombre del servicio de MySQL
  mysql_root_password = "example_password"
  node_port           = 30001
}

module "apache" {
  source    = "./HTTP-Apache"
  namespace = "default"
  app_name  = "php-webserver"
  replicas  = 1
  image     = "${local.minikube_ip}:5000/php-webserver:latest"
  node_port = 30002
}

module "mysql" {
  source              = "./MySQL"
  namespace           = "default"
  app_name            = "mysql"
  replicas            = 1
  image               = "mysql:latest"
  mysql_root_password = "example_password"
  mysql_database      = "BASE-01A"
  mysql_user          = "user"
  mysql_password      = "password"
  node_port           = 30003
}
