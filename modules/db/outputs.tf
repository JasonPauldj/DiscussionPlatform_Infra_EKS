output "db-host" {
  value       = aws_db_instance.db.address
  description = "The address of the DB instance"
  sensitive   = true
}