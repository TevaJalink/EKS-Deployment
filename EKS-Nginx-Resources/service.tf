resource "kubernetes_service" "nginx-service" {
  metadata {
    name      = "nginx-service"
    namespace = "nginx-ns"
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx-deployment.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}