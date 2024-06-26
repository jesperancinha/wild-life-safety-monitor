FROM eclipse-temurin:21-alpine

WORKDIR /root

ENV LANG=C.UTF-8

COPY entrypoint.sh /root

COPY build/libs/wlsm-management-service.jar /root/wlsm-management-service.jar

ENTRYPOINT ["/root/entrypoint.sh"]
