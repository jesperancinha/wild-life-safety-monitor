# wlsm-messenger-pre-service

## Installation


### Generate your [.env](.env) file

1.  Copy paste your node plane definition from Kong-Konnect to [script.sh](script.sh)
2.  Run [generate-docker-compose.py](generate-docker-compose.py). It will interpret the startup script so that it can generate the ENV files with the key and certificates, in order to able to run Kong in a container
3.  Just run [docker-compose](docker-compose.yaml) up -d

### Protobuf

#### [Linux](https://docs.brew.sh/Homebrew-on-Linux) and [MAC-OS](https://brew.sh/) with brew

```shell
brew install protobuf
```

## Resources

-   [gRPC Gateway @ KongHQ](https://docs.konghq.com/hub/kong-inc/grpc-gateway/)
-   [gRPC Gateway @ GitHub](https://grpc-ecosystem.github.io/grpc-gateway/)
-   [protobuf @ GitHub](https://github.com/protocolbuffers/protobuf)
-   [Manage gRPC Services with kong @ KongHQ](https://konghq.com/blog/engineering/manage-grpc-services-kong)
-   [gRPC quickstart in Kotlin](https://grpc.io/docs/languages/kotlin/quickstart/)
-   [Creating versions catalog in Gradle](https://docs.gradle.org/current/userguide/platforms.html#sub:version-catalog)

## About me

[![GitHub followers](https://img.shields.io/github/followers/jesperancinha.svg?label=Jesperancinha&style=for-the-badge&logo=github&color=grey "GitHub")](https://github.com/jesperancinha)
