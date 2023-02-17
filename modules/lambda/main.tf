resource "aws_lambda_function" "first_lambda" {
  function_name    = "first_lambda"
  filename         = "../python/python_lambda.zip"
  role             = aws_iam_role.iam_lambda_role.arn
  handler          = "python_lambda.lambda_handler"
  runtime          = "python3.7"
  timeout          = 30
  memory_size      = 128
  source_code_hash = filebase64sha256("python_lambda.zip")
  environment {
      variables = {
        TABLE_NAME = aws_dynamodb_table.lambda_table.name
      }
  }
  event_source_mapping {
    event_source_arn = var.event_s3
    starting_position = "LATEST"
  }
}
