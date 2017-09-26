FROM php:5.6-apache
MAINTAINER Klinnex

#Install of dependency
RUN apt-get update && \
    apt-get install -y\
    php-pear\
    php5-curl\
    php5-mysql\
    php5-json\
    php5-gmp\
    php5-mcrypt\
    php5-ldap\
    php5-gd\
    php-net-socket\
    libgmp-dev\
    libmcrypt-dev\
    libpng12-dev\
    libfreetype6-dev\
    libjpeg-dev\
    libpng-dev\
    libldap2-dev\
    libnet-snmp-perl\
    libcrypt-hcesha-perl\
    libcrypt-des-perl\
    libdigest-hmac-perl\
    libio-pty-perl\
    libnet-telnet-perl\
    libalgorithm-diff-perl\
    librrds-perl\
    php5-snmp\
    rrdtool\
    libsocket6-perl\
    libweb-simple-perl\
    libnet-ntp-perl\
    libnet-dns-perl\
    rm -rf /var/lib/apt/lists/*

# Configure apache and required PHP modules
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

COPY php.ini /usr/local/etc/php/

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
     sed -i 's!/var/www/html!/var/nedi/html!g' /etc/apache2/sites-enabled/000-default.conf
RUN ls /usr/local/etc/php/
     #sed -i -e "s/^upload_max_filesize.*/upload_max_filesize = 2G/" /etc/php5/apache2/php.ini 
 #     sed -i -e "s/^post_max_size.*/post_max_size = 1G/" /etc/php5/apache2/php.ini

EXPOSE 443
