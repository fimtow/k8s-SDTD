import json
import time
import requests
from requests.structures import CaseInsensitiveDict
from kafka import KafkaProducer

topic = "candles"
url = "https://api.coincap.io/v2/candles?exchange=poloniex&interval=m1&baseId=ethereum&quoteId=bitcoin"
KAFKA_BROKER_URL = ["broker-svc.default.svc.cluster.local:29092","broker2-svc.default.svc.cluster.local:29093","broker3-svc.default.svc.cluster.local:29094"]
headers = CaseInsensitiveDict()
headers["Accept-Encoding"] = "gzip"
headers["Authorization"] = "Bearer 2601a948-6c55-46a8-8e8a-3b80c4d0861b"

producer = KafkaProducer(bootstrap_servers=KAFKA_BROKER_URL)

#start_time = time.time()
#(time.time() - start_time)<10
while True:
    response = requests.get(url, headers=headers)
    candles = json.loads(response.text.encode('utf8'))
    producer.send(topic, json.dumps(candles["data"]).encode())
    time.sleep(50)
