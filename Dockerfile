FROM ubuntu:16.04
MAINTAINER Klinnex

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
    sudo rm -rf /var/lib/apt/lists/*

EXPOSE 80 443
