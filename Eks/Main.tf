provider "aws" {
  region = "us-west-2"  # Change to your desired region
}
 
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn = aws_iam_role.eks_role.arn
 
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}
 
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}
 
resource "aws_eks_node_group" "my_nodegroup" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-nodegroup"
  node_role_arn   = aws_iam_role.eks_node_role.arn
 
  scaling_config {
    min_size = 1
    desired_size = 2
    max_size = 3
  }
 
  remote_access {
    ec2_ssh_key = "your-ssh-key"
  }
}
 
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
 
# Define your worker node security group, VPC, and subnets here
# ...
 
output "cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}
 
output "kubeconfig" {
  value = aws_eks_cluster.my_cluster.kubeconfig
}
