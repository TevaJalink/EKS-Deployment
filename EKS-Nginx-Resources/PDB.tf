resource "kubernetes_pod_disruption_budget_v1" "nginx-distribution-budget" {
  metadata {
    name      = "nginx-distribution-budget"
    namespace = "nginx-ns"
  }
  spec {
    min_available = "1"
    selector {
      match_labels = {
        app = kubernetes_deployment.nginx-deployment.spec.0.template.0.metadata[0].labels.app
      }
    }
  }
}