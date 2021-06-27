FROM ubuntu
RUN rm -rf /bin \
    && sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
COPY --from=nevinee/s6-overlay-stage:latest / /
ENTRYPOINT ["/init"]