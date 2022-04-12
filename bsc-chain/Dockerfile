FROM debian:latest

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y zip unzip
RUN apt-get install -y gcc
RUN apt-get install -y manpages-dev
RUN apt-get install -y wget

RUN wget https://dl.google.com/go/go1.17.7.linux-amd64.tar.gz
RUN tar -zxvf go1.17.7.linux-amd64.tar.gz -C /
ENV GOPATH=/go GOPROXY=https://goproxy.cn PATH=$PATH:/go/bin:$GOPATH/bin

RUN wget -P /app https://github.com/bnb-chain/bsc/releases/latest/download/geth_linux
RUN chmod +x /app/geth_linux

EXPOSE 11544
EXPOSE 11544/udp
EXPOSE 11544/tcp
EXPOSE 11545
EXPOSE 11546
EXPOSE 30403
EXPOSE 30403/udp
EXPOSE 30403/tcp

ADD start.sh /app/start.sh

ENTRYPOINT ["/app/start.sh"]