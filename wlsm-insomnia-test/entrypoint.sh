#!/usr/bin/env sh
for i in {1..10}
do
  echo | inso run test --src InsomniaListener.json --verbose --env "OpenAPI env wlsm-listener-deployment.wlsm-namespace.svc.cluster.local:8080"
done
echo | inso run test --src Insomnia.json --verbose --env "OpenAPI env wlsm-aggregator-deployment.wlsm-namespace.svc.cluster.local:8082"
