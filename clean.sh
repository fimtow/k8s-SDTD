#!/usr/bin/env bash
set -e
sed -i 's/'"$BUCKET"'/xxxxxxxxxxx/' $CLUSTER_NAME.yaml
gsutil rm -r gs://$BUCKET