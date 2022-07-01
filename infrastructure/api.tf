data "aws_iam_policy_document" "apigateway_sts_policy"  {
    statement {
        effect = "Allow"

        principals {
            type = "Service"
            identifiers = ["apigateway.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "api_gateway_execution_role" {
    name = "flashcardz-api-gateway"
    path = "/"
    assume_role_policy = data.aws_iam_policy_document.apigateway_sts_policy.json
}

resource "aws_api_gateway_rest_api" "flashcardz_api_gateway" {
    name = "flashcardz-api-gateway"
}

resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.flashcardz_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.flashcardz_api_gateway.root_resource_id
  path_part   = "flashcard"
}

resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example.id
  rest_api_id   = aws_api_gateway_rest_api.flashcardz_api_gateway.id
}

# resource "aws_api_gateway_integration" "example" {
#   http_method = aws_api_gateway_method.example.http_method
#   resource_id = aws_api_gateway_resource.example.id
#   rest_api_id = aws_api_gateway_rest_api.flashcardz_api_gateway.id
#   type        = "MOCK"
# }

resource "aws_api_gateway_integration" "integration" {
  http_method = aws_api_gateway_method.example.http_method
  resource_id = aws_api_gateway_resource.example.id
  rest_api_id = aws_api_gateway_rest_api.flashcardz_api_gateway.id
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.flashcard.invoke_arn
}

resource "aws_api_gateway_deployment" "employees_rest_api_deployment" {
    depends_on=[
        aws_api_gateway_method.example,
        aws_api_gateway_integration.integration
    ]
    rest_api_id = "${aws_api_gateway_rest_api.flashcardz_api_gateway.id}"
    stage_name = "v1"
    variables = {
        deployed_at = timestamp()
    }
}