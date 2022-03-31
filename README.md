# Configure .env file from S3 bucket files

## 1. Setup:
- Copy ``.env.sample`` and create ``.env`` file from it.
- Add the AWS credentials and bucket path to it.

## 2. Build docker image:
- ``docker build .``
- ``docker images``
- Take the image id
- ``docker run -p <port>:<port> -d <image_id>``

## 3. Sample Script:

**i. Download the file bash script**

```bash
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
```

**ii. Dockerfile config**

```python
FROM python:3.9

# working directory inside container
WORKDIR /app

# copy requirements package files
COPY ./requirements.txt /app/requirements.txt

# install dep
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

# copy the application
COPY . /app

# make entrypoint script executable
RUN chmod +x entrypoint/start_backend.sh
RUN chmod +x entrypoint/download_config.sh

# Download config from S3
RUN bash entrypoint/download_config.sh

# start application
CMD ["/bin/bash","-c","./entrypoint/start_backend.sh"]

EXPOSE 5000

```

