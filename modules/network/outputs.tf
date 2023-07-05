output "vpc-id" {
  description = "The id of the VPC"
  value       = aws_vpc.main.id
}

output "private-subnet-ids" {
  value = aws_subnet.privatesubnets[*].id
}

output "db-sg-ids" {
  value = [aws_security_group.db-sg.id]
}

output "app-sg-ids" {
  value = [aws_security_group.dp-app-sg.id]
}

# output "lb-sg-ids" {
#   description = "The list of ids of Security Groups that need to be assigned to Load Balancer"
#   value       = [aws_security_group.lb-sg.id]
# }

output "public-subnet-ids" {
  value = aws_subnet.publicsubnets[*].id
}