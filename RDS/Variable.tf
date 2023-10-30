variable "subnet_ids" {
  type    = list(string)
  description = "List of subnet IDs for the RDS instance."
}
 
variable "db_username" {
  type        = string
  description = "Database username for WordPress."
}
 
variable "db_password" {
  type        = string
  description = "Database password for WordPress."
}
 
# Add more variables as needed
