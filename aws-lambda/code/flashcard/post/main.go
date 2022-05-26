package main

import (
	"flashcardz/serverless-api/layers/dynamoDBInterface"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
)

type FlashcardItem struct {
	Id              string
	DeckId          string
	AuthorId        string
	AuthorDeckIndex string
}

var dynamoDBClient = dynamoDBInterface.CreateDBClient()
var TABLE_NAME = "flashcards"

func LambdaHandler() {

	item := FlashcardItem{
		Id:              "1337",
		DeckId:          "1337",
		AuthorId:        "1337",
		AuthorDeckIndex: "1338",
	}

	marshalledItem, marshalError := dynamodbattribute.MarshalMap(item)
	if marshalError != nil {
		fmt.Printf("%s", marshalError)
		return
	}

	fmt.Printf("%s", marshalledItem)

	_, dbError := dynamoDBClient.PutItem(&dynamodb.PutItemInput{
		Item:      marshalledItem,
		TableName: aws.String(TABLE_NAME),
	})

	if dbError != nil {
		fmt.Printf("%s", dbError)
		return
	}
}

func main() {
	lambda.Start(LambdaHandler)
}
