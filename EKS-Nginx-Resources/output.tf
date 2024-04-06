output "nginx_service_dns" {
  value       = kubernetes_service.nginx-service.status.0.load_balancer.0.ingress.0.hostname
  description = "The public DNS of the nginx service"
}