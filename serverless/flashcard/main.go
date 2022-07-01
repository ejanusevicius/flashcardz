package main

import (
	"encoding/json"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/events"
)

type Response struct {
	Name         string `json:"name"`
	MembersCount int    `json:"membersCount"`
}

func HandleRequest(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	resp := Response{
		Name: "Eddie",
		MembersCount: 20,
	}

	jsonResp, _ := json.Marshal(resp)

	return events.APIGatewayProxyResponse{
		Body: string(jsonResp),
		Headers: map[string]string{"Content-Type":"application/json"},
		StatusCode: 200,
	}, nil
}

func main() {
	lambda.Start(HandleRequest)
}