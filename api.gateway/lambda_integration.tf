resource "aws_api_gateway_authorizer" "jwt_authorizer" {
  name                           = "${var.prefix}-jwt-authorizer"
  rest_api_id                    = aws_api_gateway_rest_api.fastfood_api.id
  authorizer_uri                  = "arn:aws:apigateway:${var.aws-region}:lambda:path/2015-03-31/functions/${var.middleware-lambda-arn}/invocations"
  authorizer_result_ttl_in_seconds = 300
  type                           = "TOKEN"
  identity_source                = "method.request.header.Authorization"
}

resource "aws_lambda_permission" "auth_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvokeAuth"
  action        = "lambda:InvokeFunction"
  function_name = var.auth-lambda-arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.fastfood_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "middleware_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvokeMiddleware"
  action        = "lambda:InvokeFunction"
  function_name = var.middleware-lambda-arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.fastfood_api.execution_arn}/*/*"
}

# /auths (POST)
resource "aws_api_gateway_integration" "auths_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.auths.id
  http_method             = aws_api_gateway_method.auths_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws-region}:lambda:path/2015-03-31/functions/${var.auth-lambda-arn}/invocations"
}

# /clients/identify (POST)
resource "aws_api_gateway_integration" "clients_identify_integration" {
  rest_api_id             = aws_api_gateway_rest_api.fastfood_api.id
  resource_id             = aws_api_gateway_resource.clients_identify.id
  http_method             = aws_api_gateway_method.clients_identify_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws-region}:lambda:path/2015-03-31/functions/${var.auth-lambda-arn}/invocations"
}