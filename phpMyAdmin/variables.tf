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
}

variable "phpmyadmin_password" {
  type        = string
  description = "The phpMyAdmin password"
  default     = "password"
}

variable "mysql_host" {
  type        = string
  description = "MySQL host address"
  default     = "mysql"  # Asegúrate de reemplazar con la dirección IP o nombre de host de tu servidor MySQL
}

variable "mysql_root_password" {
  type        = string
  description = "MySQL root password"
  default     = "example_password"  # Asegúrate de reemplazar con la contraseña de root de tu servidor MySQL
}
