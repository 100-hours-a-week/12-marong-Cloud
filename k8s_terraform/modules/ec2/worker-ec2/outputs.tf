output "worker-public-ips" {
  value = aws_instance.marong-worker[*].public_ip
}

output "worker-instance-ids" {
  value = aws_instance.marong-worker[*].id
}