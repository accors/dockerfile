FROM debian:stable-slim
LABEL MAINTAINER="accors"

COPY ./tuic.sh /usr/local/bin/tuic.sh
COPY ./example.json /etc/example.json

RUN apt update && \
    apt install -y wget && \
    chmod +x /usr/local/bin/tuic.sh 

ENTRYPOINT ["tuic.sh"]
