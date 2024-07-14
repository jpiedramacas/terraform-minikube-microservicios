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
  minikube_ip = "192.168.49.2"  # Reemplaza esto con la IP real de Minikube
}

module "phpmyadmin" {
  source    = "./phpMyAdmin"
  namespace = "default"
  app_name  = "phpmyadmin"
  replicas  = 1
  image     = "${local.minikube_ip}:5000/phpmyadmin:latest"
  phpmyadmin_user     = "user"
  phpmyadmin_password = "password"
  mysql_host          = "mysql"
  mysql_root_password = "example_password"
}

module "apache" {
  source    = "./HTTP-Apache"
  namespace = "default"
  app_name  = "php-webserver"
  replicas  = 1
  image     = "${local.minikube_ip}:5000/php-webserver:latest"
}

module "mysql" {
  source              = "./MySQL"
  namespace           = "default"
  app_name            = "mysql"
  replicas            = 1
  image               = "${local.minikube_ip}:5000/mysql:latest"
  mysql_root_password = "example_password"
  mysql_database      = "BASE-01A"
  mysql_user          = "user"
  mysql_password      = "password"
}
