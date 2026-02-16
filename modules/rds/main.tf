resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "${var.subnet_group_name}-db-subnet-group-module"
  subnet_ids = [var.private_subnet, var.private_subnet2]

  tags = {
    Name = "${var.subnet_group_name}-db-subnet-group-module"
  }
}

## RDS instance

resource "aws_db_instance" "rds_db_instance" {
  identifier     = "${var.subnet_group_name}-db-instance-module"
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = true

  db_subnet_group_name   = aws_db_subnet_group.rds_db_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false

  # Good defaults; tweak per environment
  multi_az                = false # true for prod HA (needs Multi-AZ pricing)
  backup_retention_period = 7
  deletion_protection     = true
  skip_final_snapshot     = false
  apply_immediately       = false
}