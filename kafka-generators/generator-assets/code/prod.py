from kafka import KafkaConsumer

# Import sys module
import sys

# Define server with port
bootstrap_servers = ["broker-svc.default.svc.cluster.local:29092","broker2-svc.default.svc.cluster.local:29093","broker3-svc.default.svc.cluster.local:29094"]

# Define topic name from where the message will recieve
topicName = 'assets'

# Initialize consumer variable
consumer = KafkaConsumer (topicName, group_id ='group2',bootstrap_servers =
   bootstrap_servers)

# Read and print message from consumer
for msg in consumer:
	print("Topic Name=%s,Message=%s"%(msg.topic,msg.value))

