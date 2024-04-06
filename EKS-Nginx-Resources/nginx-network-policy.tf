resource "kubernetes_network_policy" "nginx-network-policy" {
  metadata {
    name      = "nginx-network-policy"
    namespace = "nginx-ns"
  }

  spec {
    pod_selector {
      match_labels = {
        app = kubernetes_deployment.nginx-deployment.spec.0.template.0.metadata[0].labels.app
      }
    }
    policy_types = ["Ingress"]

    ingress {
      from {
        ip_block {
          cidr = "${kubernetes_service.nginx-service.spec.0.cluster_ip}/32"
        }
      }
      ports {
        protocol = "TCP"
        port     = 80
      }
    }
  }
  depends_on = [ kubernetes_service.nginx-service ]
}