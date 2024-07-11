variable "namespace" {
  type        = string
  description = "The namespace in which to deploy MySQL"
  default     = "default"
}

variable "app_name" {
  type        = string
  description = "The name of the MySQL application"
  default     = "mysql"
}

variable "replicas" {
  type        = number
  description = "The number of replicas of MySQL to create"
  default     = 1
}

variable "image" {
  type        = string
  description = "The Docker image to deploy for MySQL"
  default     = "mysql:latest"
}

variable "mysql_root_password" {
  type        = string
  description = "MySQL root password"
  default     = "admin01"  # Asegúrate de reemplazar con una contraseña segura
}

variable "mysql_database" {
  type        = string
  description = "MySQL database name"
  default     = "BASE-01A"  # Asegúrate de reemplazar con el nombre de tu base de datos
}

variable "mysql_user" {
  type        = string
  description = "MySQL user name"
  default     = "user"  # Asegúrate de reemplazar con el nombre de tu usuario MySQL
}

variable "mysql_password" {
  type        = string
  description = "MySQL user password"
  default     = "password"  # Asegúrate de reemplazar con una contraseña segura para el usuario MySQL
}
