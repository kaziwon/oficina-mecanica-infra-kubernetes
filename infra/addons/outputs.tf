output "load_balancer_hostname" {
  description = "Hostname publico do Kong Gateway."
  value       = try(data.kubernetes_service_v1.kong_proxy.status[0].load_balancer[0].ingress[0].hostname, null)
}

output "api_gateway_url" {
  description = "URL publica base exposta pelo Kong Gateway."
  value       = try("http://${data.kubernetes_service_v1.kong_proxy.status[0].load_balancer[0].ingress[0].hostname}", null)
}

output "kong_namespace" {
  description = "Namespace Kubernetes do Kong Gateway."
  value       = kubernetes_namespace_v1.kong.metadata[0].name
}

output "new_relic_cluster_name" {
  description = "Nome usado para identificar o cluster EKS no New Relic."
  value       = data.terraform_remote_state.cluster.outputs.eks_cluster_name
}
