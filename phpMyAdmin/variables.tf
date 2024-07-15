variable "namespace" {
  type        = string
  description = "The namespace in which to deploy phpMyAdmin"
  default     = "default"
}

variable "app_name" {
  type        = string
  description = "The name of the phpMyAdmin application"
  default     = "phpmyadmin"
}

variable "replicas" {
  type        = number
  description = "The number of replicas of phpMyAdmin to create"
  default     = 1
}

variable "image" {
  type        = string
  description = "The Docker image to deploy for phpMyAdmin"
  default     = "phpmyadmin:latest"
}

variable "phpmyadmin_user" {
  type        = string
  description = "The phpMyAdmin username"
  default     = "user"
  sensitive   = true
}

variable "phpmyadmin_password" {
  type        = string
  description = "The phpMyAdmin password"
  default     = "password"
  sensitive   = true
}

variable "mysql_host" {
  type        = string
  description = "MySQL host address"
  default     = "mysql"
}

variable "mysql_root_password" {
  type        = string
  description = "MySQL root password"
  default     = "example_password"
  sensitive   = true
}

variable "node_port" {
  type        = number
  description = "The NodePort for phpMyAdmin service"
  default     = 30001  # Ensure this is within the valid range
}
