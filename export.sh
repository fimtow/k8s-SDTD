export BUCKET="xxxxxxxxxxx"
export CLUSTER_NAME="psdtd.k8s.local"
export KOPS_FEATURE_FLAGS=AlphaAllowGCE
export KOPS_STATE_STORE=gs://${BUCKET}/
export PROJECT=$(gcloud config get-value project)