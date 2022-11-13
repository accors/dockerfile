FROM debian:stable-slim

ENV TZ=Asia/Shanghai

WORKDIR /root
COPY ./snell.sh /root/snell.sh

RUN apt update && apt install -y unzip wget && \
    apt clean && \
    apt autoclean && \
    rm -fr /var/lib/apt/lists/* && \
    chmod +x /root/snell.sh 

ENTRYPOINT ["/root/snell.sh"]