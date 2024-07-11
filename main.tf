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

module "apache" {
  source = "./HTTP-Apache"
  
  namespace = "default"
  app_name  = "php-webserver"
  replicas  = 1
  image     = "${minikube ip}:5000/php-webserver:latest"
}
