FROM debian:latest

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y gcc
RUN apt-get install -y manpages-dev
RUN apt-get install -y wget

RUN wget https://dl.google.com/go/go1.17.7.linux-amd64.tar.gz
RUN tar -zxvf go1.17.7.linux-amd64.tar.gz -C /
ENV GOPATH=/go GOPROXY=https://goproxy.cn PATH=$PATH:/go/bin:$GOPATH/bin

RUN go install github.com/ethereum/go-ethereum/cmd/geth@latest

EXPOSE 8546/tcp
EXPOSE 30304/tcp 30304/udp

WORKDIR /app

ADD start.sh /app/start.sh

ENTRYPOINT ["/app/start.sh"]