FROM cassandra:latest
# Install Pip
RUN apt-get update
RUN apt-get install -y python3-pip

# Install and configure python packages
ADD requirements.txt /build/
RUN pip install -r /build/requirements.txt

# Copy files
ADD ./webserver.py /
ADD ./db_schema.cql /
ADD ./templates /templates
EXPOSE 5000

# Start the process
#CMD ["python3 /webserver.py"] 