#!/bin/sh

# exit if any error
set -e

# populate the access key on environment
source .env

# login to aws cli
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_REGION

# copy bucket on local container
aws s3 cp $BUCKET_PATH .
