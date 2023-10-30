provider "aws" {
  region = "us-west-2"  # Change to your desired region
}
 
resource "aws_security_group" "elb_sg" {
  name_prefix        = "elb-"
  description        = "ELB security group"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this for security
  }
}
 
resource "aws_lb" "my_elb" {
  name               = "my-elb"
  internal           = false
  load_balancer_type = "application"
  enable_deletion_protection = false
 
  enable_http2     = true
 
  security_groups = [aws_security_group.elb_sg.id]
  subnets         = var.subnet_ids
  enable_deletion_protection = false
 
  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60
  enable_cross_zone_load_balancing = false
 
  enable_deletion_protection = false
 
  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60
  enable_cross_zone_load_balancing = false
 
  tags = {
    Name = "my-elb"
  }
}
