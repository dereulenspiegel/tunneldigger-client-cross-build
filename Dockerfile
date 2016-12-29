FROM debian:8.6

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'deb http://emdebian.org/tools/debian/ jessie main' >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y install curl git && \
  curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add - && \
  dpkg --add-architecture mipsel && \
  apt-get update && \
  apt-get -y install crossbuild-essential-mipsel && \
  echo "APT::Default-Release \"jessie\";" > /etc/apt/apt.conf.d/20defaultrelease && \
  apt-get -y install libnl-3-200:mipsel libnl-3-dev libnl-genl-3-200:mipsel libnl-genl-3-dev && \
  cd /root/ && git clone https://github.com/wlanslovenija/tunneldigger.git

ENV CC=mipsel-linux-gnu-cc
ENV LD=mipsel-linux-gnu-ld
ENV AS=mipsel-linux-gnu-as

ADD Makefile /root/tunneldigger/client/Makefile

WORKDIR /root/tunneldigger/client

CMD make
