output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet" {
  description = "public subnet id 목록"
  value = [for s in aws_subnet.public_subnet : s.id]
}

output "private_subnet" {
  description = "private subnet id 목록"
  value = [for s in aws_subnet.private_subnet : s.id]
}

output "db_subnet" {
  description = "db subnet id 목록"
  value = [for s in aws_subnet.db_subnet : s.id]
}