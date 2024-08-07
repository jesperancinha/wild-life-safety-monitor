include ../Makefile.mk

run-container:
	docker ps --format '{{.ID}}' -q --filter="name=/test-container"| xargs -I {} docker stop {}
	docker ps --format '{{.ID}}' -q --filter="name=/test-container"| xargs -I {} docker rm {}
	docker build -t test .
	docker run -d --name test-container test

run-local-tests:
	local/entrypoint.sh
