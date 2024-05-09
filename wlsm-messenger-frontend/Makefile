include ../Makefile.mk

install-all:
	brew install protobuf protoc-gen-grpc-web
	npm install -g protoc-gen-js
generate-code:
	protoc -I=../wlsm-messenger-protos/src/main/proto messenger.proto \
      --js_out=import_style=commonjs:. \
      --grpc-web_out=import_style=commonjs,mode=grpcwebtext:.