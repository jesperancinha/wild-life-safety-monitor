#!/usr/bin/env sh
for i in {1..10}
do
  echo | inso run test --src InsomniaListener.json --verbose --env "OpenAPI env localhost:8080"
done
echo | inso run test --src Insomnia.json --verbose --env "OpenAPI env localhost:8082"
