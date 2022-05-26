# resource "aws_s3_bucket" "dummyfiledatabase" {
#     bucket = "filedb"
# }

# resource "aws_s3_bucket_object" "flashcardFile" {
#     bucket = aws_s3_bucket.dummyfiledatabase.id
#     key="flashcards.json"
#     source = filemd5("./json/flashcards.json")
# }

# resource "aws_s3_bucket" "b" {
#   bucket = "my-tf-test-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.b.id
#   acl    = "private"
# }