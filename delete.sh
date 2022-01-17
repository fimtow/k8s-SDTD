#!/usr/bin/env bash
set -e
kubectl delete -f deployement
kops delete cluster ${CLUSTER_NAME} --yes
sed -i 's/'"${BUCKET}"'/xxxxxxxxxxx/' ${CLUSTER_NAME}.yaml
sed -i 's/'"${PROJECT}"'/yyyyyyyyyyy/' ${CLUSTER_NAME}.yaml
gsutil rm -r gs://${BUCKET}