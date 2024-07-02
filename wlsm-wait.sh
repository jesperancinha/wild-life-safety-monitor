#!/bin/bash

check_pods_status() {
  kubectl get pods --all-namespaces -o json | jq -r '
    .items[] |
    .metadata.namespace as $namespace |
    .metadata.name as $pod_name |
    [
      .status.containerStatuses[] |
      select(.ready == false) |
      .name
    ] as $not_ready |
    if ($not_ready | length) > 0 then
      [$namespace, $pod_name, $not_ready]
    else
      empty
    end
  '
}

while : ; do
  NOT_READY_PODS=$(check_pods_status)
  if [ -z "$NOT_READY_PODS" ]; then
    echo "All containers in all pods are running and ready."
    break
  else
    echo "Waiting for the following pods to be ready:"
    echo "$NOT_READY_PODS" | jq -r '. | @csv'  # Print in a readable CSV format
    sleep 1
  fi
done
