resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name           = "flashcards"
    billing_mode   = "PROVISIONED"
    read_capacity  = 20
    write_capacity = 20
    hash_key       = "Id"
    range_key      = "DeckId"

    attribute {
      name = "Id"
      type = "S"
    }

    attribute {
        name = "DeckId"
        type = "S"
    }

    attribute {
        name = "AuthorId"
        type = "S"
    }

    ttl {
        attribute_name = "TimeToExist"
        enabled        = false
    }

    global_secondary_index {
        name = "AuthorDeckIndex"
        hash_key = "DeckId"
        range_key = "AuthorId"
        write_capacity = 10
        read_capacity = 10
        projection_type = "INCLUDE"
        non_key_attributes = ["Id"]
    }

    tags = {
        Name        = "dynamodb-table-1"
        Environment = "production"
    }
}