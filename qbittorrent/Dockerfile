## 修改自：https://github.com/crazy-max/docker-qbittorrent/blob/master/Dockerfile

FROM alpine AS builder
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache \
       autoconf \
       automake \
       boost-dev \
       build-base \
       cppunit-dev \
       git \
       libtool \
       ncurses-dev \
       qt5-qttools-dev \
    && rm -rf /tmp/* /var/cache/apk/*
ARG LIBTORRENT_VERSION
ARG LIBTORRENT_URL="https://gitee.com/evine/libtorrent.git"
RUN cd /tmp \
    && git clone --branch v${LIBTORRENT_VERSION} --recurse-submodules ${LIBTORRENT_URL} \
    && cd libtorrent \
    && ./autotool.sh \
    && ./configure CXXFLAGS="-std=c++14" --with-libiconv \
    && make -j$(nproc) \
    && make install-strip \
    && ls -al /usr/local/lib/
ARG QBITTORRENT_VERSION
ARG QBITTORRENT_URL="https://gitee.com/evine/qBittorrent.git"
RUN cd /tmp \
    && git clone --branch release-${QBITTORRENT_VERSION} ${QBITTORRENT_URL} \
    && cd qBittorrent \
    && ./configure --disable-gui \
    && make -j$(nproc) \
    && make install \
    && ls -al /usr/local/bin/ \
    && qbittorrent-nox --help

FROM alpine
COPY --from=builder /usr/local/lib/libtorrent-rasterbar.so.10.0.0 /usr/lib/libtorrent-rasterbar.so.10
COPY --from=builder /usr/local/bin/qbittorrent-nox /usr/bin/qbittorrent-nox
ENV QBITTORRENT_HOME="/home/qbittorrent" \
    TZ="Asia/Shanghai" \
    PUID="1500" \
    PGID="1500" \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ "
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache \
       curl \
       openssl \
       qt5-qtbase \
       shadow \
       tzdata \
       jq \
       bash \
       s6-overlay \
    && rm -rf /tmp/* /var/cache/apk/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && useradd qbittorrent -u ${PUID} -U -m -d ${QBITTORRENT_HOME} -s /bin/bash
COPY s6-overlay /
WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/init"]
