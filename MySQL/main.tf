resource "kubernetes_config_map" "mysql_initdb_config" {
  metadata {
    name      = "${var.app_name}-config"
    namespace = var.namespace
  }

  data = {
    MYSQL_ROOT_PASSWORD = var.mysql_root_password
    MYSQL_USER          = var.mysql_user
    MYSQL_PASSWORD      = var.mysql_password
    MYSQL_DATABASE      = var.mysql_database
  }
}

resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = var.image

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.mysql_initdb_config.metadata[0].name
                key  = "MYSQL_ROOT_PASSWORD"
              }
            }
          }
          env {
            name = "MYSQL_DATABASE"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.mysql_initdb_config.metadata[0].name
                key  = "MYSQL_DATABASE"
              }
            }
          }
          env {
            name = "MYSQL_USER"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.mysql_initdb_config.metadata[0].name
                key  = "MYSQL_USER"
              }
            }
          }
          env {
            name = "MYSQL_PASSWORD"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.mysql_initdb_config.metadata[0].name
                key  = "MYSQL_PASSWORD"
              }
            }
          }
          port {
            container_port = 3306
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mysql_service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      protocol    = "TCP"
      port        = 3306
      target_port = 3306
    }
    type = "ClusterIP"
  }

  depends_on = [
    kubernetes_deployment.mysql_deployment
  ]
}
