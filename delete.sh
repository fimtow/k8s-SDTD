kubectl delete -f deployement
kops delete cluster $NAME --yes
sed -i 's/'"$BUCKET"'/xxxxxxxxxxx/' $NAME.yaml
gsutil rm -r gs://$BUCKET