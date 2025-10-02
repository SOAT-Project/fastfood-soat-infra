data "aws_lb" "eks_alb" {
  arn = var.eks-alb-arn
}

resource "aws_api_gateway_vpc_link" "eks_link" {
  name        = "eks-vpc-link"
  description = "VPC Link para EKS"
  target_arns = [data.aws_lb.eks_alb.arn]
}

resource "aws_api_gateway_method" "root_any" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  http_method             = aws_api_gateway_method.root_any.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.eks_link.id
}
