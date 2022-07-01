resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

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

data "archive_file" "flashcard_zip" {
  type        = "zip"
  source_file = "../serverless/flashcard/main"
  output_path = "/lambda_zipped/flashcard.zip"
}

resource "aws_lambda_function" "flashcard" {
  depends_on = [
    data.archive_file.flashcard_zip
  ]
  function_name = "resource_flashcard"
  filename = "/lambda_zipped/flashcard.zip"
  handler = "main"
  source_code_hash = filebase64sha256("/lambda_zipped/flashcard.zip")
  role = aws_iam_role.lambda_execution_role.arn
  runtime = "go1.x"
  memory_size = 128
  timeout = 10
}
