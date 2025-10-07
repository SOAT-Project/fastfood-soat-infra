data "aws_vpc" "fastfood" {
  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-fastfood-vpc"] # Usando prefix
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.fastfood.id]
  }
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.fastfood.id]
  }
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}