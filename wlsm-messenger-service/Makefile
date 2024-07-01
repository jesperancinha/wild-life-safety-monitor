include ../Makefile.mk

KONG_CONTAINER_ID ?= $KONG_CONTAINER_ID

b: clean build
clean:
	if [ -d build ]; then rm -r build; fi;
build:
	./gradlew build
wrapper:
	export GRADLE_VERSION=$(GRADLE_VERSION); \
	gradle wrapper --no-validate-url
dcup:
	docker-compose up -d
copy-kong-proto:
	docker cp ../wlsm-messenger-protos/messenger-kong.proto $(KONG_CONTAINER_ID):/usr/local/kong
	docker cp ../wlsm-messenger-protos/messenger-kong.proto $(KONG_CONTAINER_ID):/usr/local/kong/include
post-example:
	curl -XPOST localhost:8000/api/v1/message/ -d  '{"text":"text", "author":"author" }'
post-example-1:
	curl -XPOST localhost:50051//v1/message/ -H 'Content-Type:application/json' -d  '{"text":"text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text ", "author":"author" }'
generate-env-file:
	python generate-docker-compose.py
