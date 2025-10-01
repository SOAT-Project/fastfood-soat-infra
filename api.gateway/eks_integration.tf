resource "aws_api_gateway_resource" "app" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = ""
}

resource "aws_api_gateway_vpc_link" "eks_link" {
  name        = "eks-vpc-link"
  description = "VPC Link para EKS"
  target_arns = [var.eks_alb_arn]
}

resource "aws_api_gateway_method" "app_get" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.app.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "app_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.app.id
  http_method             = aws_api_gateway_method.app_get.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks_alb_dns}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.eks_link.id
}
