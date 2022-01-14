CLUSTER_IP=$(kubectl get services my-service | awk 'FNR == 2 {print $4}')
CLUSTER_IP="<pending>"
while [ "${CLUSTER_IP}" = "<pending>" ]
do
    CLUSTER_IP=$(kubectl get services my-service | awk 'FNR == 2 {print $4}')
done
echo The cluster is ready, you can reach it at $CLUSTER_IP