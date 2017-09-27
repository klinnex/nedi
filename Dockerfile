FROM php:7.1-apache
MAINTAINER Klinnex

ENV APACHE_DOCUMENT_ROOT /var/nedi
#Install of dependency
RUN apt-get update &&\
    apt-get install -y\
    #mysql-server\
    libnet-snmp-perl\
    libcrypt-rijndael-perl\
    libcrypt-hcesha-perl\
    libcrypt-des-perl\
    libdigest-hmac-perl\
    libio-pty-perl\
    libnet-telnet-perl\
    libalgorithm-diff-perl\
    librrds-perl\
    mysqli\
   # php7.0-snmp\
   # php7.0-gd\
   # php7.0-mcrypt\
   # rrdtool\
   # libsocket6-perl &&\
    && rm -rf /var/lib/apt/lists/*


#RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf &&\
#    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

 # Configure apache and required PHP modules
# RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
#     docker-php-ext-install mysqli && \
#     docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include && \
#     docker-php-ext-install gd && \
#     docker-php-ext-install sockets && \
#     docker-php-ext-install pdo_mysql && \
#     docker-php-ext-install gettext && \
#     ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
#     docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu && \
#     docker-php-ext-install gmp && \
#     docker-php-ext-install mcrypt && \
#     docker-php-ext-install pcntl && \
#     docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
#     docker-php-ext-install ldap && \
#     echo ". /etc/environment" >> /etc/apache2/envvars && \
#     a2enmod rewrite
# 
# COPY php.ini /usr/local/etc/php/
# 
# ENV NEDI_SOURCE http://www.nedi.ch/pub
# ENV NEDI_VERSION 1.6C
# 
# RUN cpanm \
#       Net::SNMP\
#       Net::Telnet\
#       Algorithm::Diff\
# #RUN DBD::MySQL
#       DBI\
# #RUN cpanm RRDs
#       Socket6\
#       LWP::UserAgent\
#       Net::DNS::Resolver\
#       Net::NTP\
#       IO::Tty
# #RUN cpanm libnet
# 
# 
# ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/
# RUN mkdir /var/nedi &&\
#       tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /var/nedi &&\
#       chown -R www-data:www-data /var/nedi &&\
#       chmod 775 /var/nedi/html/log/ &&\
#       ln -s /var/nedi/nedi.conf /etc/nedi.conf &&\
#      sed -i 's!/var/www/html!/var/nedi/html!g' /etc/apache2/sites-enabled/000-default.conf
# RUN ls /usr/local/etc/php/
#      #sed -i -e "s/^upload_max_filesize.*/upload_max_filesize = 2G/" /etc/php5/apache2/php.ini 
#  #     sed -i -e "s/^post_max_size.*/post_max_size = 1G/" /etc/php5/apache2/php.ini


EXPOSE 443 80
 
