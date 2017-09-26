FROM php:5.6-apache
MAINTAINER Klinnex

#Install of dependency
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
      libnet-telnet-cisco-perl\
      cpanminus &&\
      rm -rf /var/lib/apt/lists/*
      
# Configure apache and required PHP modules 

ENV NEDI_SOURCE http://www.nedi.ch/pub
ENV NEDI_VERSION 1.5C

RUN cpanm \
      Net::SNMP\
      Net::Telnet\
      Algorithm::Diff\
#RUN DBD::MySQL
      DBI\
#RUN cpanm RRDs
      Socket6\
      LWP::UserAgent\
      Net::DNS::Resolver\
      Net::NTP\
      IO::Tty
#RUN cpanm libnet

ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/
RUN mkdir /var/nedi &&\
      tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /var/nedi &&\
      chown -R www-data:www-data /var/nedi &&\
      chmod 775 /var/nedi/html/log/ &&\
      ln -s /var/nedi/nedi.conf /etc/nedi.conf &&\
     sed -i 's!/var/www/html!/var/nedi/html!g' /etc/apache2/sites-enabled/000-default.conf &&\
     le /etc/ph*
     #sed -i -e "s/^upload_max_filesize.*/upload_max_filesize = 2G/" /etc/php5/apache2/php.ini 
 #     sed -i -e "s/^post_max_size.*/post_max_size = 1G/" /etc/php5/apache2/php.ini

EXPOSE 443
