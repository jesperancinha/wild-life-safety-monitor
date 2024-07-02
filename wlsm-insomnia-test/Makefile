include ../Makefile.mk

run-container:
	docker stop test-container
	docker rm test-container
	docker build -t test .
	docker run -d --name test-container test
