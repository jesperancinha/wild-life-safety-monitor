#!/usr/bin/env sh
max=10
for i in $(seq 1 $max)
do
  echo | inso run test --src InsomniaListener.json --verbose --env "OpenAPI env wlsm-listener-deployment.wlsm-namespace.svc.cluster.local:8080"
done
echo | inso run test --src Insomnia.json --verbose --env "OpenAPI env wlsm-aggregator-deployment.wlsm-namespace.svc.cluster.local:8082"

export LC_CTYPE="en_US.UTF-8"

result=$(kubectl get pods --sort-by=.status.startTime -n wlsm-namespace -o jsonpath='{.items[-1].status.containerStatuses[0].state.terminated.reason}')

podname=$(kubectl get pods --sort-by=.status.startTime -n wlsm-namespace -o jsonpath='{.items[-1].metadata.name}')
podname=$(echo $podname)
kubectl logs $podname -n wlsm-namespace;
if [ "$result" != 'Completed' ]; then
  exit 1
fi
