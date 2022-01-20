#!/bin/bash

while true
do
	bin/spark-submit --class Main --master spark://spark-master-svc.spark.svc.cluster.local:7077 --packages org.apache.spark:spark-streaming-kafka-0-8_2.11/2.4.1,com.datastax.spark:spark-cassandra-connector_2.11/2.4.1,commons-configuration:commons-configuration:1.6  --conf spark.cassandra.connection.host=cassandra-clip.default.svc.cluster.local --conf spark.driver.bindAddress=0.0.0.0 --conf spark.shuffle.service.enabled=true --conf spark.dynamicAllocation.enabled=true code/rsi_2.11-1.0.jar
	sleep 1
done
