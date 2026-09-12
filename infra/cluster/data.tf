data "terraform_remote_state" "database" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket_name
    key          = "oficina-mecanica/database/terraform.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}

data "aws_iam_roles" "eks_cluster" {
  name_regex = ".*-LabEksClusterRole-.*"
}

data "aws_iam_roles" "eks_node" {
  name_regex = ".*-LabEksNodeRole-.*"
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Component   = "kubernetes-infrastructure"
    ManagedBy   = "Terraform"
  }

  eks_cluster_role_arn = one(data.aws_iam_roles.eks_cluster.arns)
  eks_node_role_arn    = one(data.aws_iam_roles.eks_node.arns)
}

check "academy_eks_cluster_role" {
  assert {
    condition     = length(data.aws_iam_roles.eks_cluster.arns) == 1
    error_message = "A conta deve possuir exatamente uma role LabEksClusterRole."
  }
}

check "academy_eks_node_role" {
  assert {
    condition     = length(data.aws_iam_roles.eks_node.arns) == 1
    error_message = "A conta deve possuir exatamente uma role LabEksNodeRole."
  }
}
