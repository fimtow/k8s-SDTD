export BUCKET=stdt-kops-storage-$RANDOM
export NAME="psdtd.k8s.local"
export KOPS_FEATURE_FLAGS=AlphaAllowGCE
export KOPS_STATE_STORE=gs://$BUCKET/
gsutil mb gs://$BUCKET/
sed -i 's/xxxxxxxxxxx/'"$BUCKET"'/' $NAME.yaml
kops create -f $NAME.yaml
kops update cluster $NAME --yes
kops export kubeconfig --admin
kops validate cluster --wait 10m
kubectl apply -f deployement