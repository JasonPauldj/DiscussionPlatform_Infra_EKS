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

variable "cidr-subnets" {
  description = "The list of cidr subnets for the private and public subnets"
  type        = list(string)
  default = [
    "10.0.0.0/20",
    "10.0.16.0/20",
    "10.0.32.0/20",
    "10.0.48.0/20",
  ]
}

# variable "server-port" {
#   description = "The port for the server"
#   type        = number
#   default     = 8080
# }