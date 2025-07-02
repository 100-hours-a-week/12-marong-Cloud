output "master-public-ip" {
  value = aws_instance.marong-master[*].public_ip
}

output "master-instance-ids" {
  value = aws_instance.marong-master[*].id
}