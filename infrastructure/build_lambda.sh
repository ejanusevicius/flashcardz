#!/bin/bash
cd ..
cd aws-lambda/code/flashcard/get/
GOOS=linux CGO_ENABLED=0 go build -ldflags "-s -w" -o main main.go