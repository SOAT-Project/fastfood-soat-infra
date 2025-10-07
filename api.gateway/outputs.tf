output "api_gateway_id" {
  value = aws_api_gateway_rest_api.fastfood_api.id
}

output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.fastfood_api.id}.execute-api.${var.aws-region}.amazonaws.com/${aws_api_gateway_stage.fastfood_api_stage.stage_name}"
}
