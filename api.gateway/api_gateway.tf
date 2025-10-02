resource "aws_api_gateway_deployment" "fastfood_api_deploy" {
  depends_on = [
    aws_api_gateway_integration.root_integration,
    aws_api_gateway_integration.auths_integration,
    aws_api_gateway_integration.clients_identify_integration,
    aws_api_gateway_authorizer.jwt_authorizer
  ]

  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
}

resource "aws_api_gateway_stage" "fastfood_api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  deployment_id = aws_api_gateway_deployment.fastfood_api_deploy.id
  stage_name    = "v1"
}

resource "aws_api_gateway_rest_api" "fastfood_api" {
  name        = "${var.prefix}-fastfood-soat-api"
  description = "API Gateway para FastFood SOAT"
}
