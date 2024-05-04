#!/usr/bin/env bash

curl "https://search.maven.org/solrsearch/select?q=g:io.grpc+AND+a:protoc-gen-grpc-kotlin&wt=json" -o versionInfo.json
# shellcheck disable=SC2002
version=$(cat versionInfo.json | jq -r '.response.docs[0].latestVersion')
curl -O "https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-kotlin/""$version""/protoc-gen-grpc-kotlin-""$version""-jdk8.jar"
cat plugin-template.sh | sed s/SOME_VERSION/"${version}"/g > protoc-gen-grpc-kotlin.sh
chmod +x protoc-gen-grpc-kotlin.sh
