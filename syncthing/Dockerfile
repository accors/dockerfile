ARG GOVERSION=latest
FROM golang:$GOVERSION AS builder
ARG SYNCTHING_VERSION=1.16.1

WORKDIR /src_tmp
RUN apt update \
    && apt install -y wget tar \
    && wget https://github.com/syncthing/syncthing/archive/refs/tags/v${SYNCTHING_VERSION}.tar.gz \
    && tar -zxf v${SYNCTHING_VERSION}.tar.gz \
    && mv /src_tmp/syncthing-${SYNCTHING_VERSION} /src
WORKDIR /src

ENV CGO_ENABLED=0
ENV BUILD_HOST=syncthing.net
ENV BUILD_USER=docker
RUN rm -f syncthing && go run build.go -no-upgrade build syncthing

FROM alpine

VOLUME ["/var/syncthing"]

RUN apk update -f \
    && apk upgrade \
    && apk add --no-cache ca-certificates su-exec tzdata \
    && rm -rf /var/cache/apk/*

COPY --from=builder /src/syncthing /bin/syncthing
COPY --from=builder /src/script/docker-entrypoint.sh /bin/entrypoint.sh

ENV PUID=1000 \
    PGID=1000 \
    HOME=/var/syncthing \
    TZ=Asia/Shanghai \
    STGUIADDRESS=0.0.0.0:55521

ENTRYPOINT ["/bin/entrypoint.sh", "/bin/syncthing", "-home", "/var/syncthing/config"]