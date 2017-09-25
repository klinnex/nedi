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
      libnet-telnet-cisco-perl\
      cpanminus
RUN   rm -rf /var/lib/apt/lists/*
      
# Configure apache and required PHP modules 

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

ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/
RUN mkdir /opt/nedi
RUN tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /opt/nedi
RUN chown -R www-data:www-data /opt/nedi
RUN chmod 775 /opt/nedi/html/log/
RUN rm -rf /var/www/html
RUN ln -s /opt/nedi/html/ /var/www/html
RUN ls /opt/
EXPOSE 443
