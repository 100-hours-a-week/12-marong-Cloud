output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
    description = "public subnet id 목록"
    value = [for s in values(aws_subnet.public_subnet) : s.id]
}