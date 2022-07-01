variable "region" {
    type = string
}

variable "aws_access_key" {
    type = string
}

variable "aws_secret_key" {
    type = string
}

variable "lambda_invoke_url" {
    default = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions"
}