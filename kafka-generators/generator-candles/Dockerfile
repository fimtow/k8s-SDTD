FROM python:3.6

WORKDIR /usr/app

ADD ./requirements.txt ./
RUN pip install -r requirements.txt
ADD ./code ./
#RUN nohup bash -c "python3 assets.py &"
CMD ["python3","candles.py"]
