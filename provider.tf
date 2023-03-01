provider "aws" {
access_key = var.access_key
secret_key = var.secret_key
region = var.region
}
module "s3" {
  source = "./modules/s3"
}
module "dynamodb" {
  source = "./modules/dynamodb"
}
module "lambda" {
  source = "./modules/lambda"
  event_s3 = module.s3.s3_arn
  db_table = module.dynamodb.dynamodb_arn
  s3_bucket = module.s3.s3_arn
}
