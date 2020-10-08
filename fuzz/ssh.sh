#!/bin/sh

set -e

kubectl get svc kek-ssh -n kek -o json | jq '.metadata.annotations."field.cattle.io/publicEndpoints"' -r | jq '.[0] | "ssh kek@\(.addresses[0]) -p \(.port) -o CheckHostIP=no"' -r
