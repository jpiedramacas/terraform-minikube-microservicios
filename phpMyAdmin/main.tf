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

          env {
            name  = "PMA_USER"
            value = var.phpmyadmin_user
          }
          env {
            name  = "PMA_PASSWORD"
            value = var.phpmyadmin_password
          }
          env {
            name  = "PMA_HOST"
            value = var.mysql_host
          }
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = var.mysql_root_password
          }
          port {
            container_port = 80
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
    }
    type = "ClusterIP"
  }

  depends_on = [
    kubernetes_deployment.phpmyadmin_deployment
  ]
}
