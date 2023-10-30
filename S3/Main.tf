provider "aws" {
  region = "us-east-1"  # Change to your desired region
}
 
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"  # Use the same bucket name as above
    key            = "terraform.tfstate"
    region         = "us-east-1"  # Change to your desired region
    encrypt        = true
  }
}
 
# Define your infrastructure resources here
