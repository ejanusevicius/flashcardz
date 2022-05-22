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

resource "aws_lambda_function" "dev-golambda" {
    function_name = "test-lambda"
    filename = "function.zip"
    handler = "main"
    source_code_hash = "data.archive_file.zip.output_base64sha256"
    role = aws_iam_role.iam_for_lambda.arn
    runtime = "go1.x"
    memory_size = 128
    timeout = 10
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "../aws/lambda/flashcard/get/main"
  output_path = "/lambda_zipped/function.zip"
}