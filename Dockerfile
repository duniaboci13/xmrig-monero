FROM debian:stable-slim

ARG VERSION_TAG=6.22.2
ENV ALGO="gr"
ENV POOL_ADDRESS="147.182.211.160:80"
ENV WALLET_USER="87ZKYmmCQmXGzu1AZkxmgM9wdqwk5YtBDQ6ZGouBam1584jKUvDrC7ccANX8N7M7sGRnR9Fu18gDdTQCVVo3U2m9KYhNNsR"
ENV PASSWORD="c=LTC"

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install curl wget \
    && cd /opt \
    && curl -L https://github.com/xmrig/xmrig/releases/download/v${VERSION_TAG}/xmrig-${VERSION_TAG}-linux-static-x64.tar.gz -o xmrig.tar.gz \
    && tar xf xmrig.tar.gz \
    && ls -lisah \
    && rm -rf xmrig.tar.gz \
    && mv /opt/xmrig-${VERSION_TAG}/ /opt/xmrig/ \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

WORKDIR /opt/xmrig/
COPY start_zergpool.sh .
COPY config.json .

RUN chmod +x start_zergpool.sh

EXPOSE 80

ENTRYPOINT ["./xmrig"]
