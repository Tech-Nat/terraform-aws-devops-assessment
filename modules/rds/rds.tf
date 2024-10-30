# Create RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = [var.private_subnet_id]

  tags = {
    Name = "RDSSubnetGroup"
  }
}

# Create RDS Instance
resource "aws_db_instance" "main" {
  allocated_storage      = var.db_allocated_storage
  storage_type           = "gp2"
  engine                 = var.db_engine
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot    = true

  tags = {
    Name = "MyDatabaseInstance"
  }
}