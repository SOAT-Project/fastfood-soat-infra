resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.fastfood-vpc.id

  tags = {
    Name = "fastfood-igw"
  }
}
