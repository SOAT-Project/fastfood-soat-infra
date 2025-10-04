data "aws_lb" "eks_alb" {
  arn = var.eks-alb-arn
}

resource "aws_api_gateway_vpc_link" "eks_link" {
  name        = "${var.prefix}-eks-vpc-link"
  description = "VPC Link para EKS"
  target_arns = [data.aws_lb.eks_alb.arn]
}

# /clients (POST) -> EKS (ALB), sem autenticação, mapeando para /api/clients no EKS
resource "aws_api_gateway_integration" "clients_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.clients.id
  http_method             = aws_api_gateway_method.clients_post.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}/api/clients"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.eks_link.id
}

# /{proxy+} (ANY) -> EKS (ALB), com autenticação, mapeando para /api/{proxy} no EKS
resource "aws_api_gateway_integration" "proxy_any_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy_any.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}/api/{proxy}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.eks_link.id
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
    "integration.request.header.Authorization" = ""
  }
}
