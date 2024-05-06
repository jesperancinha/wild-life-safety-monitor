OUTPUT_FILE := generated-code
DIR_OF_PROTO_FILE := .
PROTO_FILE := messenger.proto

install-homebrew-linux:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh; \
	test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)" ;\
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;\
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
install-protobuf:
	echo "Remember to install BREW first! Brew is available for Linux and MAC-OS: https://brew.sh/"
	echo "MAC-OS: https://brew.sh/"
	echo "Linux: https://docs.brew.sh/Homebrew-on-Linux"
	echo "This configuration is based on the manual provided in: https://github.com/grpc/grpc-kotlin/blob/master/compiler/README.md"
	brew install protobuf
install-plugin:
	./download-latest-kotlin-plugin.sh
install-all: install-protobuf install-plugin
protoc-gen:
	if [ -d generated-code ]; then rm -r generated-code; fi; \
	mkdir "generated-code"; \
	protoc --plugin=protoc-gen-grpckt=protoc-gen-grpc-kotlin.sh \
	  --grpckt_out="./$(OUTPUT_FILE)" --proto_path="$(DIR_OF_PROTO_FILE)" "$(PROTO_FILE)"
