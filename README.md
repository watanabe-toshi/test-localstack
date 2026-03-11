# test-localstack

LocalStack と Terraform を使って、AWS リソースをローカル環境に作成するためのサンプルです。

本番の AWS 環境を使わずに、Terraform でインフラを構築し、各サービスの基本的な動作や連携をローカルで確認できます。  
LocalStack を使った Terraform の動作確認や、AWS モック環境づくりの最初の一歩として使いやすい構成です。

## このリポジトリでできること

このリポジトリでは、Terraform を使って LocalStack 上に以下のリソースを作成します。

- S3 Bucket
- SQS Queue
- SNS Topic
- DynamoDB Table
- SNS から SQS への Subscription

あわせて、SNS Topic から SQS Queue にメッセージを送信できるように、SQS の Queue Policy も設定しています。

## 想定している用途

このサンプルは、次のような用途を想定しています。

- Terraform と LocalStack の接続確認
- AWS リソース作成の最小構成の確認
- SNS から SQS への通知連携の動作確認
- S3 / DynamoDB / SQS / SNS を含むローカル検証環境の土台づくり

## 作成されるリソース

Terraform を適用すると、以下のリソースが作成されます。

- `localstack-terraform-bucket`
- `localstack-terraform-queue`
- `localstack-terraform-topic`
- `localstack-terraform-table`

また、SNS Topic に publish したメッセージを SQS Queue で受け取れるように、Subscription と Queue Policy をあわせて作成します。

## 前提環境

以下のツールが利用できることを前提としています。

- Docker
- Terraform
- AWS CLI

## LocalStack の起動

(以下作成中)
