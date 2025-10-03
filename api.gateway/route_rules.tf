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
resource "aws_api_gateway_method" "root_any_protected" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_authorizer.id
}

# /api/swagger-ui
resource "aws_api_gateway_resource" "swagger_ui" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_rest_api.fastfood_api.root_resource_id
  path_part   = "swagger-ui"
}

# /api/swagger-ui/index.html (GET)
resource "aws_api_gateway_resource" "swagger_ui_index" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.swagger_ui.id
  path_part   = "index.html"
}

resource "aws_api_gateway_method" "swagger_ui_index_get" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  resource_id   = aws_api_gateway_resource.swagger_ui_index.id
  http_method   = "GET"
  authorization = "NONE"
}

# /swagger-ui/{proxy+} para arquivos estáticos (js, css, etc)
resource "aws_api_gateway_resource" "swagger_ui_proxy" {
  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
  parent_id   = aws_api_gateway_resource.swagger_ui.id
  path_part   = "{proxy+}"
}
