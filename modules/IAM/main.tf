resource "aws_iam_role" "EKSClusterRole" {
  name        = "EKSClusterRole"
  description = "Allows access to other AWS service resources that are required to operate clusters managed by EKS."
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "eks.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [data.aws_iam_policy.AmazonEKSClusterPolicy.arn]
}

data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  name = "AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "AmazonEKSWorkerNodePolicy" {
  name = "AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "AmazonEKS_CNI_Policy" {
  name = "AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role" "node-grp-role" {
  name        = "NodeGroupRole"
  description = "Allows nodes to make calls to other services"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [data.aws_iam_policy.AmazonEKSWorkerNodePolicy.arn, data.aws_iam_policy.AmazonEKS_CNI_Policy.arn, data.aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn]
}