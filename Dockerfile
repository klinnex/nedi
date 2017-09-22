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
      
ADD     https://www.nedi.ch/pub/nedi-1.5C.tgz /tmp/
RUN tar -xvzf /tmp/nedi-1.5C.tgz -C /var/www/html/ --strip-components=1
EXPOSE 80
