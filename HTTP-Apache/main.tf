resource "kubernetes_deployment" "apache_deployment" {
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
            name  = "MYSQL_SERVICE_HOST"
            value = "mysql-service"
          }
          env {
            name  = "MYSQL_USER"
            value = "user02"
          }
          env {
            name  = "MYSQL_PASSWORD"
            value = "password-02"
          }
          env {
            name  = "MYSQL_DATABASE"
            value = "mydatabase"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apache_service" {
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
    kubernetes_deployment.apache_deployment
  ]
}
