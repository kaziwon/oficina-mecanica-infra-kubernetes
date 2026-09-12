output "aws_region" {
  description = "Regiao em que a plataforma foi criada."
  value       = var.aws_region
}

output "ecr_repository_url" {
  description = "Endereco do repositorio privado da imagem da API."
  value       = aws_ecr_repository.api.repository_url
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS."
  value       = aws_eks_cluster.main.name
}

output "eks_node_group_name" {
  description = "Nome do grupo de nodes gerenciado pelo EKS."
  value       = aws_eks_node_group.main.node_group_name
}

output "eks_endpoint" {
  description = "Endpoint da API Kubernetes do cluster."
  value       = aws_eks_cluster.main.endpoint
}

output "update_kubeconfig_command" {
  description = "Comando local para configurar o kubectl para este cluster."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name} --profile academy"
}
