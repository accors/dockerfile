FROM alpine:latest
COPY --from=nevinee/s6-overlay-stage:latest / /
COPY --from=newfuture/ddns:latest /ddns /usr/local/bin/ddns
COPY s6-overlay /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ "
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f \
       bash \
       coreutils \
       jq \
       wget \
       curl \
       nano \
       tzdata \
       perl \
       openssl \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /root/.npm /var/cache/apk/*
ENTRYPOINT ["/init"]
WORKDIR /config
