package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type FlashcardGetEvent struct{}
type FlashcardGetResponse struct {
	Message string `json:"message:"`
}

func LambdaHandler(ctx context.Context, event FlashcardGetEvent) (FlashcardGetResponse, error) {
	fmt.Println(event)
	return FlashcardGetResponse{Message: "Hello world, from Lambda!"}, nil
}

func main() {
	lambda.Start(LambdaHandler)
}
