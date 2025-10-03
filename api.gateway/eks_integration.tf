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

# Root (ANY) -> EKS (ALB), protegido pelo authorizer
resource "aws_api_gateway_integration" "root_any_protected_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  http_method             = aws_api_gateway_method.root_any_protected.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}/api"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.eks_link.id
}

# /swagger (GET) -> EKS (ALB), sem autenticação, mapeando para /api/swagger no EKS
resource "aws_api_gateway_integration" "swagger_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.swagger.id
  http_method             = aws_api_gateway_method.swagger_get.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}/api/swagger-ui/index.html"
}

resource "aws_api_gateway_resource" "swagger_ui_proxy" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.swagger.id
  path_part   = "swagger-ui"
}

resource "aws_api_gateway_resource" "swagger_ui_proxy_sub" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.swagger_ui_proxy.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "swagger_ui_proxy_get" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.swagger_ui_proxy_sub.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "swagger_ui_proxy_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.swagger_ui_proxy_sub.id
  http_method             = aws_api_gateway_method.swagger_ui_proxy_get.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}/api/swagger-ui/{proxy}"
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.eks_link.id
}

# /api-docs/swagger-config -> EKS (ALB)
resource "aws_api_gateway_resource" "api_docs" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = "api-docs"
}

resource "aws_api_gateway_resource" "swagger_config" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.api_docs.id
  path_part   = "swagger-config"
}

resource "aws_api_gateway_method" "swagger_config_get" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.swagger_config.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "swagger_config_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.swagger_config.id
  http_method             = aws_api_gateway_method.swagger_config_get.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.eks-alb-dns}/api/api-docs/swagger-config"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.eks_link.id
}