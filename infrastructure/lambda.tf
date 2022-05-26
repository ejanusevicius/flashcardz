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

data "archive_file" "get_flashcard_zip" {
  type        = "zip"
  source_file = "../aws-lambda/code/flashcard/get/main"
  output_path = "/lambda_zipped/get_flashcard.zip"
}

resource "aws_lambda_function" "get_flashcard" {
  depends_on = [
    data.archive_file.get_flashcard_zip
  ]
  function_name = "get_flashcard"
  filename = "/lambda_zipped/get_flashcard.zip"
  handler = "main"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "go1.x"
  memory_size = 128
  timeout = 10
}

data "archive_file" "post_flashcard_zip" {
  type        = "zip"
  source_file = "../aws-lambda/code/flashcard/post/main"
  output_path = "/lambda_zipped/post_flashcard.zip"
}

resource "aws_lambda_function" "post_flashcard" {
  depends_on = [
    data.archive_file.post_flashcard_zip
  ]
  function_name = "post_flashcard"
  filename = "/lambda_zipped/post_flashcard.zip"
  handler = "main"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "go1.x"
  memory_size = 128
  timeout = 10
}
