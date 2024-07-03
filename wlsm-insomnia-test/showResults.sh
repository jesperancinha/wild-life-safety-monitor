#!/usr/bin/env sh

result=$(kubectl get pods --sort-by=.status.startTime -n wlsm-namespace -o jsonpath='{.items[-1].status.containerStatuses[0].state.terminated.reason}')
podname=$(kubectl get pods --sort-by=.status.startTime -n wlsm-namespace -o jsonpath='{.items[-1].metadata.name}')
podname=$(echo $podname)
kubectl logs $podname -n wlsm-namespace;
if [ "$result" != 'Completed' ]; then
  exit 1
fi
