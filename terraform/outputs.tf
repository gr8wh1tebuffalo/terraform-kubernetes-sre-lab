output "namespace_name" {
  description = "Kubernetes namespace created for the lab."
  value       = kubernetes_namespace_v1.sre_lab.metadata[0].name
}

output "application_name" {
  description = "Name of the Kubernetes Deployment."
  value       = kubernetes_deployment_v1.app.metadata[0].name
}

output "service_name" {
  description = "Name of the Kubernetes Service."
  value       = kubernetes_service_v1.app_service.metadata[0].name
}

output "application_replicas" {
  description = "Number of desired application replicas."
  value       = kubernetes_deployment_v1.app.spec[0].replicas
}

output "local_access_url" {
  description = "Local URL used after running kubectl port-forward."
  value       = "http://localhost:8080"
}