terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "cidr-subnets" {
  source          = "./modules/cidrsubnets"
  ipv4-cidr-block = var.vpc-cidr-block
  list_newbits    = var.list_newbits
}

module "network" {
  source = "./modules/network"

  vpc-cidr-block     = var.vpc-cidr-block
  no-private-subnets = var.no-private-subnets
  no-public-subnets  = var.no-public-subnets
  cidr-subnets       = module.cidr-subnets.cidr-subnets
}

module "iam" {
  source = "./modules/IAM"
}

module "db" {
  source = "./modules/db"

  privatesubnetids = module.network.private-subnet-ids
  db-sg-ids        = module.network.db-sg-ids
  username         = var.db-username
  password         = var.db-password
}

module "eks" {
  source     = "./modules/eks"
  depends_on = [module.iam]

  role_arn           = module.iam.cluster_role_arn
  private_subnet_ids = module.network.private-subnet-ids
  public_subnet_ids  = module.network.public-subnet-ids
  node_role_arn      = module.iam.node_grp_role_arn
  ssh_key_name       = var.ssh_key_name
  vpc-id             = module.network.vpc-id
  cluster_name       = var.cluster_name
  app-sg-ids         = module.network.app-sg-ids
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_auth)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_ca_auth)
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

resource "kubernetes_service_account" "service-account" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
      "app.kubernetes.io/component" = "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.eks.load-balancer-role-arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

resource "helm_release" "lb" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  depends_on = [
    kubernetes_service_account.service-account
  ]

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = module.network.vpc-id
  }

  set {
    name  = "image.repository"
    value = var.image_repo
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}