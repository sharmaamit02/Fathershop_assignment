provider "aws" {
  region = "us-east-1"  # Change to your desired region
}
 
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "my-terraform-state-bucket"  # Choose a unique bucket name
  acl    = "private"
 
  versioning {
    enabled = true
  }
 
  lifecycle_rule {
    enabled = true
 
    noncurrent_version_expiration {
      days = 30
    }
  }
}
 
resource "aws_s3_bucket_policy" "tf_state_bucket_policy" {
  bucket = aws_s3_bucket.tf_state_bucket.id
 
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["s3:GetObject", "s3:ListBucket"],
        Effect = "Allow",
        Principal = "*",
        Resource = [
          aws_s3_bucket.tf_state_bucket.arn,
          "${aws_s3_bucket.tf_state_bucket.arn}/*",
        ],
      },
    ],
  })
}
