#! /user/bin/bash
KWOK_KUBE_APISERVER_PORT=0 kwokctl create cluster || exit 1
echo "kwokctl scale node --name kwok --replicas $1"
kwokctl scale node --name kwok --replicas $1
