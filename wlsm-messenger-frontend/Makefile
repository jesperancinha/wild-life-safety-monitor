include ../Makefile.mk

b: build-npm
build-npm:
	yarn
	npx webpack ./client.js
install-all:
	brew install protobuf protoc-gen-grpc-web
	npm install -g protoc-gen-js
generate-code:
	protoc -I=../wlsm-messenger-protos/src/main/proto messenger.proto \
      --js_out=import_style=commonjs:. \
      --grpc-web_out=import_style=commonjs,mode=grpcwebtext:.
run-proxy:
	docker run -d -v "$(PWD)"/envoy.yaml:/etc/envoy/envoy.yaml:ro \
		--network=host envoyproxy/envoy:v1.22.0
