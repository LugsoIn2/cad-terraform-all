#!/bin/bash

CLUSTER=CAD-Event
CHECK_NAME=$(aws eks list-clusters | jq -r ".clusters" | grep $CLUSTER || true)


function error_on_no_exists {
    if [ "$CHECK_NAME" != "" ]; then
        echo "AWS EKS Cluster CAD-Event are available, will continue with deployment"
    else
        echo "AWS EKS Cluster CAD-Event not available, exit the deployment"
        exit 1
    fi
}

function error_on_exists {
    if [ "$CHECK_NAME" != "" ]; then
        echo "AWS EKS Cluster CAD-Event are available, exit the deployment"
        exit 1
    else
        echo "AWS EKS Cluster CAD-Event not available, continue with deployment"
    fi
}


if [ ! -z "$1" ]
then 
	case $1 in
	deploy-cluster)
		echo "execute deploy-cluster"
		error_on_exists
		;;
	deploy-services)
		echo "execute deploy-services"
		error_on_no_exists
		;;
	destroy-services)
        echo "execute destroy-services"
		error_on_no_exists
		;;
	destroy-cluster)
        echo "execute destroy-cluster"
		error_on_no_exists
		;;
	*)
		echo "Sorry, wrong argument, please try again"
		;;
  	esac	
else
    echo "no argument, exit 1"
    exit 1
fi
