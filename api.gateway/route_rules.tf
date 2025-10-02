# /auths (public - POST)
resource "aws_api_gateway_resource" "auths" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = "auths"
}

resource "aws_api_gateway_method" "auths_post" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.auths.id
  http_method   = "POST"
  authorization = "NONE"
}

# /clients (public - POST, EKS)
resource "aws_api_gateway_resource" "clients" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = "clients"
}

resource "aws_api_gateway_method" "clients_post" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.clients.id
  http_method   = "POST"
  authorization = "NONE"
}

# /clients/identify (public - POST)
resource "aws_api_gateway_resource" "clients_identify" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.clients.id
  path_part   = "identify"
}

resource "aws_api_gateway_method" "clients_identify_post" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.clients_identify.id
  http_method   = "POST"
  authorization = "NONE"
}

# Root e outros endpoints do EKS protegidos pelo authorizer
resource "aws_api_gateway_method" "root_any_protected" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_authorizer.id
}
