#!/usr/bin/env bash
set -e
#kubectl delete -f deployement
kubectl delete -f deployement/kafka.yaml 
kubectl delete -f deployement/spark.yaml
kubectl delete -f deployement/spark2.yaml 
#kubectl delete service -n spark driverui 
#kubectl delete service -n spark2 driverui
kubectl delete -f deployement/visualisation.yaml
kops delete cluster ${CLUSTER_NAME} --yes
sed -i 's/'"${BUCKET}"'/xxxxxxxxxxx/' ${CLUSTER_NAME}.yaml
sed -i 's/'"${PROJECT}"'/yyyyyyyyyyy/' ${CLUSTER_NAME}.yaml
gsutil rm -r gs://${BUCKET}