output "memcached_endpoint" {
  description = "ElastiCache Memcached endpoint for configuring your PHP sessions."
  value = aws_elasticache_cluster.memcached.configuration_endpoint_address
}
