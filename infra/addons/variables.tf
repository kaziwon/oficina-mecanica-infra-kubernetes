variable "aws_region" {
  description = "Regiao em que o cluster EKS foi criado."
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Bucket S3 compartilhado que armazena os estados Terraform."
  type        = string

  validation {
    condition     = length(trimspace(var.state_bucket_name)) > 0
    error_message = "O nome do bucket de estado nao pode ser vazio."
  }
}

variable "new_relic_license_key" {
  description = "Chave de ingestao usada pelo agente de infraestrutura do New Relic."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.new_relic_license_key)) > 0
    error_message = "A license key do New Relic nao pode ser vazia."
  }
}
