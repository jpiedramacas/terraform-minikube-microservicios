variable "namespace" {
  type        = string
  description = "The namespace in which to deploy the application"
  default     = "default"
}

variable "app_name" {
  type        = string
  description = "The name of the application"
  default     = "apache-server"
}

variable "replicas" {
  type        = number
  description = "The number of replicas to create"
  default     = 1
}

variable "image" {
  type        = string
  description = "The Docker image to deploy"
  default     = "httpd:latest"
}

variable "node_port" {
  type        = number
  description = "The NodePort for the service"
  default     = 30036  # Asegúrate de reemplazar con un número de puerto adecuado
}
