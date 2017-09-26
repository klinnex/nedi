FROM ubuntu:16.04
MAINTAINER Klinnex

RUN apt-get update && apt-get -y -q install\
  apache2\
  libapache2-mod-php5\
  mysql-server\
  libnet-snmp-perl\
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
  rrdtool\
  libsocket6-perl\
  libweb-simple-perl\
  libnet-ntp-perl\
  libnet-dns-perl && \
  rm -rf /var/lib/apt/lists/*
  
  
  RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-install mysqli && \
    docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include && \
    docker-php-ext-install gd && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install gettext && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu && \
    docker-php-ext-install gmp && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install pcntl && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-install ldap && \
    echo ". /etc/environment" >> /etc/apache2/envvars && \
    a2enmod rewrite
    
    EXPOSE 443
