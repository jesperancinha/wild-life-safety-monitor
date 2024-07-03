FROM ubuntu

WORKDIR /root

ENV LANG=C.UTF-8

RUN apt update

RUN apt install curl sudo npm -y

COPY entrypoint.sh /root

COPY insomnia/install-insomnia-linux.sh /root

COPY insomnia/install-inso.linux.sh /root

RUN apt install libgtk-3-0 libnss3 libxss1 libatspi2.0-0 libsecret-1-0 -y

RUN /root/install-insomnia-linux.sh

RUN /root/install-inso.linux.sh

COPY insomnia/Insomnia.json /root

COPY insomnia/InsomniaListener.json /root

ENTRYPOINT ["/root/entrypoint.sh"]
