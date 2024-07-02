FROM ubuntu

WORKDIR /root

ENV LANG=C.UTF-8

RUN apt update

RUN apt install curl sudo npm -y

COPY entrypoint.sh /root

COPY insomnia/install-insomnia-linux.sh /root

COPY insomnia/install-inso.linux.sh /root

COPY insomnia/Insomnia.json /root


ENTRYPOINT ["/root/entrypoint.sh"]
