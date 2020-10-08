#!/bin/sh

cd $(dirname $(realpath $0))

kubectl config use-context space
docker build -t registry.osiris.services/kek/fuzz .
docker push registry.osiris.services/kek/fuzz

kubectl apply -f kube/run.yml
kubectl rollout restart deployment kek-run -n kek
