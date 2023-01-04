#!/bin/bash
CLUSTER=CAD-Event-2

CHECK_NAME=$(aws eks list-clusters | jq -r ".clusters" | grep $CLUSTER || true)

if [ "$CHECK_NAME" != "" ]; then
    echo "AWS EKS Cluster CAD-Event are available, will continue with deployment"
else
    echo "AWS EKS Cluster CAD-Event not available, exit the deployment"
    exit 1
fi