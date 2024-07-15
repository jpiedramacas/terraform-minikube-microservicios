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
  default     = "example_password"  # Replace with a secure password
  sensitive   = true
}

variable "mysql_database" {
  type        = string
  description = "MySQL database name"
  default     = "BASE-01A"  # Replace with your database name
}

variable "mysql_user" {
  type        = string
  description = "MySQL user name"
  default     = "user"  # Replace with your MySQL user name
}

variable "mysql_password" {
  type        = string
  description = "MySQL user password"
  default     = "password"  # Replace with a secure password
  sensitive   = true
}

variable "node_port" {
  type        = number
  description = "The NodePort for MySQL service"
  default     = 30036
}
