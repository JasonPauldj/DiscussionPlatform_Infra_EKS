variable "privatesubnetids" {
  description = "The private subnet ids"
}

variable "db-sg-ids" {
  description = "The SG ids for the DB instance"
}

variable "password" {
  description = "The password for the DB"
  type        = string
  sensitive   = true
}

variable "username" {
  description = "The name of the root user for the DB"
  type        = string
  sensitive   = true
}