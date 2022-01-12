FROM python:3.8

# Install and configure python packages
ADD requirements.txt /build/
RUN pip install -r /build/requirements.txt

# Copy files
ADD ./webserver.py /
ADD ./templates /templates
EXPOSE 5000

# Start the process
CMD ["python webserver.py"] 