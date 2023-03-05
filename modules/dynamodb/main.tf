resource "aws_dynamodb_table" "dynamodb_lambda" {
  name           = "dynamodb_lambda"
  read_capacity  = 1
  write_capacity = 1

  attribute {
      name = "key_name"
      type = "S"
    }

   attribute {
      name = "value_name"
      type = "S"
    }
  

  global_secondary_index {
    name               = "Demo"
    hash_key           = "key_name"
    range_key          = "value_name"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
  }
}
