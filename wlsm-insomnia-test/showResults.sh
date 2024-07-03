#!/usr/bin/env sh

podname=$(kubectl get pods --sort-by=.status.startTime -n wlsm-namespace -o jsonpath='{.items[-1].metadata.name}')
podname=$(echo $podname)
namespace="wlsm-namespace"

get_pod_status() {
    kubectl get pod "$podname" -n "$namespace" -o jsonpath='{.status.phase}'
}

while true; do
    status=$(get_pod_status)
    echo "Current status of pod $podname: $status"
    if [ "$status" = 'Succeeded' ] || [ "$status" = 'Failed' ] || [ "$status" = 'Error' ]; then
        echo "Pod $podname has reached a terminal status: $status"
        break
    fi
    sleep 5
done

result=$(kubectl get pods --sort-by=.status.startTime -n wlsm-namespace -o jsonpath='{.items[-1].status.containerStatuses[0].state.terminated.reason}')
kubectl logs $podname -n $namespace;
if [ "$result" != 'Completed' ]; then
  exit 1
fi
