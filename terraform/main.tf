resource "kubernetes_namespace_v1" "sre_lab" {
  metadata {
    name = "sre-lab"
  }
}
resource "kubernetes_config_map_v1" "app_config" {
  metadata {
    name      = "sre-lab-config"
    namespace = kubernetes_namespace_v1.sre_lab.metadata[0].name
  }

  data = {
    APP_ENV         = "local-lab"
    WELCOME_MESSAGE = "Hello from Alec's Terraform Kubernetes SRE lab"
  }
}

resource "kubernetes_secret_v1" "app_secret" {
  metadata {
    name      = "sre-lab-secret"
    namespace = kubernetes_namespace_v1.sre_lab.metadata[0].name
  }

  data = {
    DEMO_API_KEY = "fake-demo-api-key"
  }

  type = "Opaque"
}

resource "kubernetes_deployment_v1" "app" {
  wait_for_rollout = true
  metadata {
    name      = "sre-lab-app"
    namespace = kubernetes_namespace_v1.sre_lab.metadata[0].name
    labels = {
      app = "sre-lab-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "sre-lab-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "sre-lab-app"
        }
      }

      spec {
        container {
          name  = "sre-lab-app"
          image = "nginxdemos/hello:latest"

          port {
            container_port = 80
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }

            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 20
          }

          env {
            name = "APP_ENV"

            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.app_config.metadata[0].name
                key  = "APP_ENV"
              }
            }
          }

          env {
            name = "DEMO_API_KEY"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.app_secret.metadata[0].name
                key  = "DEMO_API_KEY"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "app_service" {
  metadata {
    name      = "sre-lab-app-service"
    namespace = kubernetes_namespace_v1.sre_lab.metadata[0].name
  }

  spec {
    selector = {
      app = "sre-lab-app"
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}