provider "aws" {
access_key = var.access_key
secret_key = var.secret_key
region = var.region
}
module "s3_bucket" {
  source = "./modules/s3"
}
module "aws_lambda" {
  source = "./modules/lambda"
  event_s3 = module.s3.s3_arn
}
