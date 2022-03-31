from fastapi import FastAPI
import uvicorn

from dotenv import load_dotenv

import os

app = FastAPI()

# load env variable
try:
    # local env file
    load_dotenv(".env")

    # s3 bucket env file name
    env_file_name = os.environ["ENV_FILE_NAME"]
    load_dotenv(env_file_name)
except Exception as e:
    raise Exception("Cannot load the env file from S3 bucket")

# health check endpoint
@app.get("/status")
async def root():
    return {"message": "Service is Up and Running"}, 200

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5000)
