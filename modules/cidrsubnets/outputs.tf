output "cidr-subnets" {
  description = "The list of cidr subnets generated"
  value       = cidrsubnets(var.ipv4-cidr-block, var.list_newbits...)
}