resource "aws_api_gateway_deployment" "fastfood_api_deploy" {
  depends_on = [
    aws_api_gateway_integration.auths_client_integration,
    aws_api_gateway_integration.auths_staff_integration,
    aws_api_gateway_integration.clients_post_integration,
    aws_api_gateway_integration.swagger_ui_index_integration,
    aws_api_gateway_integration.swagger_ui_proxy_integration,
    aws_api_gateway_integration.swagger_config_integration,
    aws_api_gateway_integration.root_any_protected_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.fastfood_api.id
}

resource "aws_api_gateway_stage" "fastfood_api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.fastfood_api.id
  deployment_id = aws_api_gateway_deployment.fastfood_api_deploy.id
  stage_name    = "api"
}

resource "aws_api_gateway_rest_api" "fastfood_api" {
  name        = "${var.prefix}-fastfood-soat-api"
  description = "API Gateway para FastFood SOAT"
}
