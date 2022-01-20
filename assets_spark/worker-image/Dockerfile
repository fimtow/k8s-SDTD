FROM gettyimages/spark
COPY ./conf /usr/spark-2.4.1/conf
COPY ./conf /conf
EXPOSE 7012 7013 7014 7015 8881 8081
CMD ["bin/spark-class", "org.apache.spark.deploy.worker.Worker", "spark://spark-master-svc.spark2.svc.cluster.local:7077"]
