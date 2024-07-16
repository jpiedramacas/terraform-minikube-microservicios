variable "namespace" {
  type        = string
  description = "The namespace in which to deploy the application"
  default     = "default"
}

variable "app_name" {
  type        = string
  description = "The name of the application"
  default     = "mysql"
}

variable "replicas" {
  type        = number
  description = "The number of replicas to create"
  default     = 1
}

variable "image" {
  type        = string
  description = "The Docker image to deploy"
  default     = "mysql:latest"
}

variable "mysql_root_password" {
  type        = string
  description = "The root password for MySQL"
  default     = "admin-password"
}

variable "mysql_database" {
  type        = string
  description = "The name of the MySQL database"
  default     = "mydatabase"
}

variable "mysql_user" {
  type        = string
  description = "The MySQL user"
  default     = "user02"
}

variable "mysql_password" {
  type        = string
  description = "The password for the MySQL user"
  default     = "password-02"
}
