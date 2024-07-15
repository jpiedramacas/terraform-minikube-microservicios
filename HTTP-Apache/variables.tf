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
  default     = "php-webserver:latest"
}

variable "node_port" {
  type        = number
  description = "The NodePort for the Apache service"
  default     = 30002  # Ensure this is within the valid range
}
