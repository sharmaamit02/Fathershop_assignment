provider "aws" {
  region = "us-west-2"  # Change to your desired region
}
 
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet-group"
  subnet_ids = var.subnet_ids
  description = "My RDS subnet group"
}
 
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "RDS security group"
 
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this for security
  }
}
 
resource "aws_db_instance" "wordpress_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"  # Adjust as needed
  name                 = "wordpress"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
 
  backup_retention_period = 7  # Adjust as needed
  backup_window           = "09:30-10:30"  # Adjust as needed
  maintenance_window      = "wed:10:00-wed:11:00"  # Adjust as needed
 
  tags = {
    Name = "wordpress-db"
  }
}
