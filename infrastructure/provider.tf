provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  skip_credentials_validation = true
  skip_requesting_account_id = true
  skip_metadata_api_check = true
  s3_force_path_style = true

  endpoints {
    s3 = "http://localhost:4566"
    lambda = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}