include ../Makefile.mk

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
	curl -XPOST localhost:8000/v1/message/ -d '{"text":"text", "author":"author" }'
