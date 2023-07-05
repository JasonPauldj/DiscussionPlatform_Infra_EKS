output "oidc_url" {
  description = "The OIDC issuer url"
  value       = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

output "cluster_endpoint" {
  description = "The endpoint of the cluster"
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_ca_auth" {
  description = "The certificate authority for the cluster"
  value       = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

output "load-balancer-role-arn" {
  description = "The arn of the load balancer role"
  value       = aws_iam_role.AmazonEKSLoadBalancerControllerRole.arn
}