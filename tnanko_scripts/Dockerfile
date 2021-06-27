FROM python:alpine
LABEL maintainer="Evine Deng <evinedeng@foxmail.com>"
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f \
        bash \
        openssl \
        coreutils \
        moreutils \
        git \
        wget \
        curl \
        nano \
        tzdata \
    && rm -rf /var/cache/apk/*
ENV HOME=/root \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ " \
    SCRIPTS_DIR="/Scripts" \
    ENABLE_QQREAD_CRONTAB=false \
    QQREAD_CRONTAB="*/10 * * * *" \
    ENABLE_BILIBILI_CRONTAB=false \
    BILIBILI_CRONTAB="15 8 * * *" \
    RM_LOG_DAYS_BEFORE=7
COPY tnanko_scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 777 /usr/local/bin/entrypoint.sh \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
    && python -m pip install --upgrade pip \
    && git clone https://github.com/TNanko/Scripts ${SCRIPTS_DIR} \
    && cd ${SCRIPTS_DIR} \
    && pip install -r requirements.txt
WORKDIR ${SCRIPTS_DIR}
ENTRYPOINT ["docker-entrypoint.sh"]