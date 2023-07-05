variable "region" {
  description = "The region where you want to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "vpc-cidr-block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "no-public-subnets" {
  description = "The number of public subnets"
  type        = number
  default     = 2
}

variable "no-private-subnets" {
  description = "The number of private subnets"
  type        = number
  default     = 2
}

variable "list_newbits" {
  description = "The newbits to be passed to cidrsubnets"
  type        = list(number)
  default     = [4, 4, 4, 4]
}

variable "ssh_key_name" {
  description = "The name of the Key Pair for SSH"
  type        = string
}

variable "cluster_name" {
  description = "The name for the eks cluster"
  default     = "dp-cluster"
  type        = string
}

variable "image_repo" {
  description = "The image repository for the load balancer controller image"
  default     = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller"
  type        = string
}

variable "db-password" {
  description = "The password for the DB"
  type        = string
  sensitive   = true
}

variable "db-username" {
  description = "The name of the root user for the DB"
  type        = string
  sensitive   = true
}