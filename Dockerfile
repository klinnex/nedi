FROM php:5.6-apache
MAINTAINER Klinnex

RUN apt-get update && \
      apt-get install -y\
      rrdtool\
      libapache2-mod-php5\
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
      && rm -rf /var/lib/apt/lists/*
      
EXPOSE 80
