variable "aws_region" {
  description = "Regiao AWS utilizada pelo ambiente da AWS Academy."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome usado para identificar os recursos do projeto."
  type        = string
  default     = "oficina-mecanica"
}

variable "environment" {
  description = "Ambiente ao qual os recursos pertencem."
  type        = string
  default     = "academy"
}

variable "state_bucket_name" {
  description = "Bucket S3 compartilhado que armazena os estados Terraform."
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster Amazon EKS."
  type        = string
  default     = "oficina-mecanica-eks"
}

variable "kubernetes_version" {
  description = "Versao Kubernetes em suporte padrao no EKS."
  type        = string
  default     = "1.36"
}

variable "node_instance_types" {
  description = "Tipos de instancia permitidos para os nodes do EKS."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_min_size" {
  description = "Quantidade minima de nodes no grupo gerenciado."
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Quantidade inicial de nodes no grupo gerenciado."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Quantidade maxima de nodes permitida no grupo gerenciado."
  type        = number
  default     = 2
}
