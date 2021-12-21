resource "aws_iam_role" "redirect_execution_role" {
  name_prefix        = "RedirectExecutionRole"
  assume_role_policy = jsonencode(
    {
      Version: "2012-10-17",
      Statement: [
        {
          Sid: "AllowLambda"
          Effect: "Allow",
          Action: "sts:AssumeRole",
          Principal: {
            Service: "lambda.amazonaws.com"
          },
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "redirect_permissions" {
  role       = aws_iam_role.redirect_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/src/redirect.js"
  output_path = "${path.module}/redirect.zip"
}

resource "aws_lambda_function" "redirect" {
  function_name = var.function_name
  role     = aws_iam_role.redirect_execution_role.arn

  filename         = "${path.module}/redirect.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  handler = "redirect.handler"
  runtime = "nodejs12.x"

  environment {
    variables = {
      REDIRECT_LOCATION = var.redirect_to
    }
  }
}
