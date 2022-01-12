#!/usr/bin/env bash
set -e
export BUCKET=stdt-kops-storage-${RANDOM}
export CLUSTER_NAME="psdtd.k8s.local"
export KOPS_FEATURE_FLAGS=AlphaAllowGCE
export KOPS_STATE_STORE=gs://${BUCKET}/
export PROJECT=$(gcloud config get-value project)
gsutil mb gs://${BUCKET}/
sed -i 's/xxxxxxxxxxx/'"${BUCKET}"'/' ${CLUSTER_NAME}.yaml
sed -i 's/yyyyyyyyyyy/'"${PROJECT}"'/' ${CLUSTER_NAME}.yaml
kops create -f ${CLUSTER_NAME}.yaml
kops update cluster ${CLUSTER_NAME} --yes
kops export kubeconfig --admin
kops validate cluster --wait 10m
kubectl apply -f deployement/cassandra.yaml
while [[ $(kubectl get pods cassandra-0 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for cassandra" && sleep 1; done
kubectl cp db_schema.cql cassandra-0:/ 
kubectl exec cassandra-0 -- cqlsh --file db_schema.cql
kubectl apply -f deployement/spark.yaml
kubectl apply -f deployement/kafka.yaml

#CLUSTER_IP=$(kubectl get services my-service | awk 'FNR == 2 {print $4}')
#CLUSTER_IP="<pending>"
#while [ "${CLUSTER_IP}" = "<pending>" ]
#do
#    CLUSTER_IP=$(kubectl get services my-service | awk 'FNR == 2 {print $4}')
#    sleep 5
# done
# echo The cluster is ready, you can reach it at ${CLUSTER_IP}