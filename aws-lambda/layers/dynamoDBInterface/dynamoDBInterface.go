package dynamoDBInterface

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/endpoints"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
)

func CreateDBClient() *dynamodb.DynamoDB {
	return dynamodb.New(session.Must(session.NewSession(&aws.Config{
		Region:      aws.String(endpoints.UsEast1RegionID),
		Credentials: credentials.NewStaticCredentials("value", "value", "value"),
		Endpoint:    aws.String("http://172.17.0.2:4566"),
	})))
}
