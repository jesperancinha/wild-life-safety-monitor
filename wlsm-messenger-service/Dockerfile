FROM eclipse-temurin:21-jdk-alpine

WORKDIR /root

ENV LANG=C.UTF-8

COPY entrypoint.sh /root

COPY build/libs/wlsm-messenger-service.jar /root/wlsm-messenger-service.jar

ENTRYPOINT ["/root/entrypoint.sh"]
