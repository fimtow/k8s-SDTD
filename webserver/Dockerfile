FROM python:3.8

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy files
COPY . .
EXPOSE 5000

# Start the process
CMD [ "python", "./webserver.py" ]
