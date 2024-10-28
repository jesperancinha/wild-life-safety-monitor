#!/usr/bin/env sh
max=10
# The inso command is sometimes updated with a different switch
# Sometimes it works with --exportFile and others with --src
# With grep we can check that before launching inso
# shellcheck disable=SC2034
for i in $(seq 1 $max)
do
  if inso help | grep exportFile; then
    echo | inso run test --exportFile InsomniaListener.json --verbose --env "OpenAPI env wlsm-listener-deployment.wlsm-namespace.svc.cluster.local:8080"
  elif inso help | grep src; then
    echo | inso run test --src InsomniaListener.json --verbose --env "OpenAPI env wlsm-listener-deployment.wlsm-namespace.svc.cluster.local:8080"
  fi
done
if inso help | grep exportFile; then
  echo | inso run test --exportFile Insomnia.json --verbose --env "OpenAPI env wlsm-aggregator-deployment.wlsm-namespace.svc.cluster.local:8082"
elif inso help | grep src; then
  echo | inso run test --src Insomnia.json --verbose --env "OpenAPI env wlsm-aggregator-deployment.wlsm-namespace.svc.cluster.local:8082"
fi
