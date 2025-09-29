resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.prefix}-fastfood-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "${var.prefix}-fastfood-nat"
  }
}