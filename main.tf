terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
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

module "apache" {
  source = "./HTTP-Apache"

  namespace = "default"
  app_name  = "php-webserver"
  replicas  = 1
  image     = "${local.minikube_ip}:5000/php-webserver:latest"
}

module "phpmyadmin" {
  source = "./phpMyAdmin"

  namespace = "default"
  app_name  = "phpmyadmin"
  replicas  = 1
  image     = "${local.minikube_ip}:5000/phpmyadmin:latest"
}
