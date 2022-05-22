resource "aws_lambda_function" "dev-golambda" {
    function_name = "dev-golambda"
    handler = "golambdabin"
    runtime = "go1.x"
    filename = "../aws/lambda/flashcard/get/function.zip"
    source_code_hash = "${base64sha256(file("../aws/lambda/flashcard/get/function.zip"))}"
    memory_size = 128
    timeout = 10
}