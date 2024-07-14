resource "kubernetes_config_map" "mysql_initdb_config" {
  metadata {
    name      = "${var.app_name}-initdb-config"
    namespace = var.namespace
  }

  data = {
    "create_table.sql" = file("${path.module}/create_table.sql")
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

          port {
            container_port = 3306
          }

          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = var.mysql_root_password
          }
          env {
            name  = "MYSQL_DATABASE"
            value = var.mysql_database
          }
          env {
            name  = "MYSQL_USER"
            value = var.mysql_user
          }
          env {
            name  = "MYSQL_PASSWORD"
            value = var.mysql_password
          }

          volume_mount {
            name      = "initdb-scripts"
            mount_path = "/docker-entrypoint-initdb.d"
          }
        }

        volume {
          name = "initdb-scripts"

          config_map {
            name = kubernetes_config_map.mysql_initdb_config.metadata[0].name
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
