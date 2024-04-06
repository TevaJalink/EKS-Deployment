resource "kubernetes_namespace" "nginx-ns" {
  metadata {
    name = "nginx-ns"
  }
}