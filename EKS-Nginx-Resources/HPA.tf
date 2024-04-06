resource "kubernetes_horizontal_pod_autoscaler_v2" "nginx-deployment-hpa" {
  metadata {
    name      = "nginx-deployment-hpa"
    namespace = "nginx-ns"
  }

  spec {
    max_replicas = 5
    min_replicas = 1

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.nginx-deployment.metadata.0.name
    }

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }

    behavior {
      scale_down {
        stabilization_window_seconds = 120
        select_policy                = "Disabled"
        policy {
          period_seconds = 60
          type           = "Pods"
          value          = 1
        }
      }
      scale_up {
        stabilization_window_seconds = 150
        select_policy                = "Disabled"
        policy {
          period_seconds = 60
          type           = "Pods"
          value          = 1
        }
      }
    }
  }
  depends_on = [
    helm_release.metrics-server
  ]
}