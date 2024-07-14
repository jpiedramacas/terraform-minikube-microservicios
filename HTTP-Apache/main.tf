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
          image_pull_policy = "IfNotPresent"
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
    type = "NodePort"
  }
  depends_on = [
    kubernetes_deployment.apache_deployment
  ]
}