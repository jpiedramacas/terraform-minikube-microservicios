variable "namespace" {
  type        = string
  description = "The namespace in which to deploy the application"
  default     = "default"
}

variable "app_name" {
  type        = string
  description = "The name of the application"
  default     = "phpmyadmin"
}

variable "replicas" {
  type        = number
  description = "The number of replicas to create"
  default     = 1
}

variable "image" {
  type        = string
  description = "The Docker image to deploy"
  default     = "phpmyadmin:latest"
}

variable "minikube_ip" {
  type        = string
  description = "The IP address of Minikube"
  default     = "192.168.49.2"  # Asegúrate de reemplazar con la IP real de Minikube
}
