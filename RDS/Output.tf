output "rds_endpoint" {
  description = "RDS endpoint for the WordPress database."
  value       = aws_db_instance.wordpress_db.endpoint
}
