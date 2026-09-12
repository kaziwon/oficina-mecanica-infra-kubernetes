resource "aws_vpc_security_group_ingress_rule" "database_from_eks" {
  security_group_id            = data.terraform_remote_state.database.outputs.database_security_group_id
  referenced_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
  from_port                    = data.terraform_remote_state.database.outputs.database_port
  to_port                      = data.terraform_remote_state.database.outputs.database_port
  ip_protocol                  = "tcp"
  description                  = "MySQL access from the EKS cluster"
}
