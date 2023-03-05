resource "aws_lambda_function" "first_lambda" {
  function_name    = "first_lambda"
  filename         = "../python/python_lambda.py"
  role             = aws_iam_role.first_lambda_role.arn
  handler          = "python_lambda.lambda_handler"
  runtime          = "python3.7"
  timeout          = 30
  memory_size      = 128
  environment {
      variables = {
        TABLE_NAME = var.db_table
      }
  }
  }
  resource "aws_lambda_event_source_mapping" "s3_to_lambda" {
    event_source_arn = var.event_s3
    function_name    = aws_lambda_function.first_lambda.arn
  }

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:DescribeTable",
        ],
        Effect = "Allow",
        Resource = var.db_table
      },
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = var.s3_bucket
      }
    ]
  })
  }
  resource "aws_iam_role" "first_lambda_role" {
  name = "first_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  }
  resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name = "Lambda_policy_attachment"
  policy_arn = aws_iam_policy.lambda_policy.arn
  roles      = [aws_iam_role.first_lambda_role.name]
}
