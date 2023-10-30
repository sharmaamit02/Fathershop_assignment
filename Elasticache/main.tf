provider "aws" {
  region = "us-west-2"  # Change to your desired region
}
 
resource "aws_security_group" "elasticache_security_group" {
  name_prefix = "elasticache-"
  description = "ElastiCache security group for PHP session data"
}
 
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name = "my-elasticache-subnet-group"
  subnet_ids = var.subnet_ids
}
 
resource "aws_elasticache_cluster" "memcached" {
  cluster_id           = "my-memcached-cluster"
  engine               = "memcached"
  node_type            = "cache.m5.large"  # Choose an appropriate instance type
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  subnet_group_name    = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids   = [aws_security_group.elasticache_security_group.id]
}
 
# Configure the cache parameter group if needed
resource "aws_elasticache_parameter_group" "memcached_parameter_group" {
  name = "my-memcached-parameter-group"
  family = "memcached1.5"
  description = "My custom parameter group for Memcached"
  parameter {
    name  = "parameter_name"
    value = "parameter_value"
  }
}
 
# Define your security group rules to control inbound/outbound traffic to ElastiCache
resource "aws_security_group_rule" "elasticache_ingress" {
  type        = "ingress"
  from_port   = 11211  # Memcached default port
  to_port     = 11211
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Adjust this to limit access as needed
  security_group_id = aws_security_group.elasticache_security_group.id
}
