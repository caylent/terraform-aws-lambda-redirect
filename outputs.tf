output "invoke_arn" {
  value       = aws_lambda_function.redirect.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
}
