output "vpc_id" {
  value = aws_vpc.fastfood-vpc.id
}

output "public_subnets_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnets_ids" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}
