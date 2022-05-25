package main

import (
	"context"

	"github.com/aws/aws-lambda-go/lambda"

	"github.com/ejanusevicius/flashcardz/aws/layers/database"
)

type FlashcardGetEvent struct{}
type FlashcardGetResponse struct {
	Message string `json:"message:"`
}

func LambdaHandler(ctx context.Context, event FlashcardGetEvent) (FlashcardGetResponse, error) {
	ReturnMessage := database.TestPackage()
	return FlashcardGetResponse{Message: ReturnMessage}, nil
}

func main() {
	lambda.Start(LambdaHandler)
}
