provider "aws" {
  region                      = "ap-northeast-1"
  access_key                  = "test"
  secret_key                  = "test"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://localhost:4566"
    sqs      = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "example" {
  bucket        = "localstack-terraform-bucket"
  force_destroy = true
}

resource "aws_sqs_queue" "example" {
  name = "localstack-terraform-queue"
}

resource "aws_dynamodb_table" "example" {
  name         = "localstack-terraform-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}

output "queue_url" {
  value = aws_sqs_queue.example.url
}

output "table_name" {
  value = aws_dynamodb_table.example.name
}
