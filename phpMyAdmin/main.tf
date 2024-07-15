resource "kubernetes_secret" "phpmyadmin_secret" {
  metadata {
    name      = "${var.app_name}-secret"
    namespace = var.namespace
  }

  data = {
    PMA_USER            = base64encode(var.phpmyadmin_user)
    PMA_PASSWORD        = base64encode(var.phpmyadmin_password)
    MYSQL_ROOT_PASSWORD = base64encode(var.mysql_root_password)
  }
}

resource "kubernetes_deployment" "phpmyadmin_deployment" {
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
            container_port = 80
          }

          env {
            name = "PMA_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.phpmyadmin_secret.metadata[0].name
                key  = "PMA_USER"
              }
            }
          }
          env {
            name = "PMA_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.phpmyadmin_secret.metadata[0].name
                key  = "PMA_PASSWORD"
              }
            }
          }
          env {
            name = "PMA_HOST"
            value = var.mysql_host
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.phpmyadmin_secret.metadata[0].name
                key  = "MYSQL_ROOT_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "phpmyadmin_service" {
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
      port        = 80
      target_port = 80
      node_port   = var.node_port
    }
    type = "NodePort"
  }

  depends_on = [
    kubernetes_deployment.phpmyadmin_deployment
  ]
}
