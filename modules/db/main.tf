resource "aws_db_subnet_group" "pri-sub-gp" {
  name       = "db-subnet-grp"
  subnet_ids = var.privatesubnetids

  tags = {
    Name = "db-subnet-grp"
  }
}

resource "aws_db_instance" "db" {
  db_subnet_group_name   = aws_db_subnet_group.pri-sub-gp.name
  username               = var.username
  password               = var.password
  instance_class         = "db.t3.micro"
  engine                 = "mysql"
  engine_version         = "8.0"
  allocated_storage      = 20
  vpc_security_group_ids = var.db-sg-ids
  identifier             = "dp-database"
  skip_final_snapshot    = true
}