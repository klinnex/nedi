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
      cpanminus\
      --no-install-recommends && rm -rf /var/lib/apt/lists/*
      
# Configure apache and required PHP modules 
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
	docker-php-ext-install mysqli && \
	docker-php-ext-install pdo_mysql && \
	docker-php-ext-install pcntl && \
        docker-php-ext-install gettext && \ 
	docker-php-ext-install sockets && \
	docker-php-ext-install gd && \
	ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
	docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu && \
	docker-php-ext-install gmp && \
        docker-php-ext-install mcrypt && \
	echo ". /etc/environment" >> /etc/apache2/envvars && \
	a2enmod rewrite

ENV NEDI_SOURCE http://www.nedi.ch/pub
ENV NEDI_VERSION 1.5C

RUN cpanm \
      Net::SNMP\
      Net::Telnet\
      Algorithm::Diff
#RUN DBD::MySQL
RUN cpanm DBI
#RUN cpanm RRDs
RUN cpanm Socket6
RUN cpanm LWP::UserAgent
RUN cpanm Net::DNS::Resolver
RUN cpanm Net::NTP
RUN cpanm IO::Tty
#RUN cpanm libnet

RUN mkdir /var/nedi
ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/
RUN ls /tmp/
RUN tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /var/nedi/
EXPOSE 443
