output "cluster_role_arn" {
  description = "The ARN of the role assigned to the cluster"
  value       = aws_iam_role.EKSClusterRole.arn
}

output "node_grp_role_arn" {
  description = "The ARN of the role assigned to the node group of the EKS cluster"
  value       = aws_iam_role.node-grp-role.arn
}