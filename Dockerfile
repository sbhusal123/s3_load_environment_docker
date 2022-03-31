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
