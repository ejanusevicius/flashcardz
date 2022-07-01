#!/bin/bash
cd ..
cd serverless/flashcard
sudo GOOS=linux CGO_ENABLED=0 go build -ldflags "-s -w" -o main main.go