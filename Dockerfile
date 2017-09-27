FROM centos:centos7
MAINTAINER Klinnex

ENV NEDI_SOURCE http://www.nedi.ch/pub
ENV NEDI_VERSION 1.5C
ADD "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/

#Install of dependency
RUN yum update &&\
    install epel-release\
    httpd\
    mod_ssl\
    php\
    php-mysql\
    mysql-server\
    php-snmp\
    php-gd\
    php-process\
    patch\
    rrdtool-perl\
    net-snmp\
    rrdtool
    
#    sudo rm -rf /var/lib/apt/lists/* &&\
#    sudo tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /opt/nedi &&\
#    sudo mv nedi /opt/ &&\
#    sudo chown -R www-data:www-data /opt/nedi &&\
#    sudo chmod 775 /opt/nedi/html/log/ \
EXPOSE 80 443
