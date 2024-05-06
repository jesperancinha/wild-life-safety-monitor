include ../Makefile.mk

b: clean build
clean:
	if [ -d build ]; then rm -r build; fi;
build:
	./gradlew build
wrapper:
	export GRADLE_VERSION=$(GRADLE_VERSION); \
	gradle wrapper --no-validate-url
