output "marong-bastion-sg_id" {
  value = aws_security_group.marong-bastion-sg.id
}

output "marong-master-sg_id" {
  value = aws_security_group.marong-master-sg.id
}

output "marong-worker-sg_id" {
  value = aws_security_group.marong-worker-sg.id
}

output "marong-alb-sg_id" {
  value = aws_security_group.marong-alb-sg.id
}

