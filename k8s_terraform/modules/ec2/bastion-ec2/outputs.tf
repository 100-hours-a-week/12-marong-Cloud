output "bastion-public-ip" {
  value = aws_instance.marong-bastion[*].public_ip
}