resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "go_zip" {
  type        = "zip"
  source_file = "../aws-lambda/code/flashcard/get/main"
  output_path = "/lambda_zipped/function_go.zip"
}

resource "aws_lambda_function" "dev-golambda" {
  depends_on = [
    data.archive_file.go_zip
  ]
  function_name = "test-lambda-go"
  filename = "/lambda_zipped/function_go.zip"
  handler = "main"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "go1.x"
  memory_size = 128
  timeout = 10
}