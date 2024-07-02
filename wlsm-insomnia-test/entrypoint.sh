#!/usr/bin/env sh
./install-insomnia-linux.sh
./install-inso.linux.sh
./install-all-linux.sh
echo | inso run test --src Insomnia.json --verbose --env "OpenAPI env wlsm-aggregator-deployment.wlsm-namespace.svc.cluster.local:8082"
