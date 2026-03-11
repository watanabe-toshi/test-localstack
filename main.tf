provider "aws" {
  region                      = "ap-northeast-1"
  access_key                  = "test"
  secret_key                  = "test"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://localhost:4566"
    sns = "http://localhost:4566"
    sqs = "http://localhost:4566"
  }
}

resource "aws_sqs_queue" "example" {
  name = "localstack-terraform-queue"
}

resource "aws_sns_topic" "example" {
  name = "localstack-terraform-topic"
}

data "aws_iam_policy_document" "allow_sns_to_sqs" {
  statement {
    sid    = "Allow-SNS-SendMessage"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.example.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.example.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "example" {
  queue_url = aws_sqs_queue.example.id
  policy    = data.aws_iam_policy_document.allow_sns_to_sqs.json
}

resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.example.arn

  depends_on = [aws_sqs_queue_policy.example]
}

output "topic_arn" {
  value = aws_sns_topic.example.arn
}

output "queue_url" {
  value = aws_sqs_queue.example.id
}
