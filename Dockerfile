FROM php:5.6-apache
MAINTAINER Klinnex

RUN apt-get update && \
      apt-get install -y\
      rrdtool\
      libnet-snmp-perl\
      libcrypt-rijndael-perl\
      libcrypt-hcesha-perl\
      libcrypt-des-perl\
      libdigest-hmac-perl\
      libio-pty-perl\
      libnet-telnet-perl\
      libalgorithm-diff-perl\
      librrds-perl\
      php5-mysql\
      php5-snmp\
      php5-gd\
      php5-mcrypt\
      libsocket6-perl\
      --no-install-recommends && rm -rf /var/lib/apt/lists/*
ENV NEDI_SOURCE http://www.nedi.ch/pub\
    NEDI_VERSION 1.5C\
ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/
RUN ls /tmp/
RUN tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /var/www/html/
EXPOSE 80
