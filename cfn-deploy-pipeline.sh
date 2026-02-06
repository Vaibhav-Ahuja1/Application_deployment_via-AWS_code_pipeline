#!/bin/bash

# This script deploys a CloudFormation stack

STACK_NAME="codepipeline-pipeline-initial-setup-cfn"
REGION="us-east-1"

echo "Deploying CloudFormation stack: $STACK_NAME"
aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file AWS_initial_setup.yaml \
  --capabilities CAPABILITY_NAMED_IAM --disable-rollback --region $REGION

if [ $? -eq 0 ]; then
  echo "CloudFormation stack $STACK_NAME deployed successfully."
else
  echo "Failed to deploy CloudFormation stack $STACK_NAME."
  exit 1
fi

# Wait for the stack to be created
aws cloudformation wait stack-create-complete --stack-name "$STACK_NAME"

if [ $? -eq 0 ]; then
  echo "Stack $STACK_NAME creation completed successfully."
else
  echo "Failed to create stack $STACK_NAME."
  exit 1
fi