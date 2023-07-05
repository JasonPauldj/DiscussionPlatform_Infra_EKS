variable "cluster_name" {
  description = "The name for the eks cluster"
  default     = "dp-cluster"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the role assigned to the cluster"
  type        = string
}

variable "vpc-id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "The value of the private subnet ids assigned to the cluster"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "The value of the public subnet ids"
  type        = list(string)
}

variable "node_role_arn" {
  description = "The ARN of the role for the nodes in the Node group of the cluster"
  type        = string
}

variable "ssh_key_name" {
  description = "The Name of the Key Pair for ssh into the ec2 instances"
  type        = string
}

variable "cluster_addons_before" {
  description = "The addons that you want to add to the cluster"
  type        = any
  default = {
    vpc-cni = {
      name = "vpc-cni"
    }
  }
}

variable "app-sg-ids" {
  description = "The ids of the security group to associate with the nodes"
  type        = list(string)
}

variable "cluster_addons_after" {
  description = "The addons that you want to add to the cluster"
  type        = any
  default = {
    coredns = {
      name = "coredns"
    }
    kube-proxy = {
      name = "kube-proxy"
    }
  }
}