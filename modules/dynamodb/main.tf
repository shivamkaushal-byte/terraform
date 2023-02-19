resource "aws_dynamodb_table" "dynamodb_lambda" {
  name           = "dynamodb_lambda"
  read_capacity  = 1
  write_capacity = 1

  attribute = [
    {
      name = "key_name"
      type = "S"
    },
    {
      name = "value_name"
      type = "S"
    },
  ]

  key_schema = [
    {
      attribute_name = "key_name"
      key_type       = "HASH"
    },
  ]
}
