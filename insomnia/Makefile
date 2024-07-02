include ../Makefile.mk

install:
	rm *.tar.xz;\
	rm inso*;\
	rm insomnia*.deb;\
	./install-insomnia-linux.sh
	./install-inso.linux.sh
run-local-file:
	echo | inso run test --src Insomnia.yaml --verbose --env "OpenAPI env localhost:8082"
run-global:
	inso run test "wild_life_safety_monitor API 1.0.0" --verbose --env "OpenAPI env localhost:8082"
export:
	echo "Use the desktop to export"
