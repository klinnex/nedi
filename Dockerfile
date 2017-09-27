FROM ubuntu:16.04
MAINTAINER Klinnex

ENV NEDI_SOURCE http://www.nedi.ch/pub
ENV NEDI_VERSION 1.5C
ADD "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/

#Install of dependency
RUN sudo apt-get update && \
    sudo apt-get install -y\
    apache2\
    libapache2-mod-php5\
    mysql-server\
    libnet-snmp-perl\
    php5-mysql\
    libnet-telnet-cisco-perl\
    php5-snmp\
    php5-gd\
    libalgorithm-diff-perl\
    rrdtool\
    librrds-perl&&\
    sudo rm -rf /var/lib/apt/lists/* &&\
    sudo tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /opt/nedi &&\
    sudo mv nedi /opt/ &&\
    sudo chown -R www-data:www-data /opt/nedi &&\
    sudo chmod 775 /opt/nedi/html/log/ \
EXPOSE 80 443
