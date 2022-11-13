FROM alpine:latest
LABEL MAINTAINER="accors"

COPY ./tuic.sh /usr/local/bin/tuic.sh
COPY ./example.json /etc/example.json

RUN apk update -f && \
    apk --no-cache add -f wget && \
    chmod +x /usr/local/bin/tuic.sh 

ENTRYPOINT ["tuic.sh"]