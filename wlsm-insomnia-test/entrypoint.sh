#!/usr/bin/env sh
max=10
for i in $(seq 1 $max)
do
  echo | inso run test --exportFile InsomniaListener.json --verbose --env "OpenAPI env wlsm-listener-deployment.wlsm-namespace.svc.cluster.local:8080"
done
echo | inso run test --exportFile Insomnia.json --verbose --env "OpenAPI env wlsm-aggregator-deployment.wlsm-namespace.svc.cluster.local:8082"
