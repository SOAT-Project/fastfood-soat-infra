# /auths (public - POST)
resource "aws_api_gateway_resource" "auths" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = "auths"
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

# /auths/client (POST) -> Lambda Auth
resource "aws_api_gateway_resource" "auths_client" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.auths.id
  path_part   = "client"
}

resource "aws_api_gateway_method" "auths_client_post" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.auths_client.id
  http_method   = "POST"
  authorization = "NONE"
}

# /auths/staff (POST) -> Lambda Auth
resource "aws_api_gateway_resource" "auths_staff" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.auths.id
  path_part   = "staff"
}

resource "aws_api_gateway_method" "auths_staff_post" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.auths_staff.id
  http_method   = "POST"
  authorization = "NONE"
}

# Root e outros endpoints do EKS protegidos pelo authorizer
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_authorizer.id
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

