FROM php:5.6-apache
MAINTAINER Klinnex

ENV APACHE_DOCUMENT_ROOT /var/nedi/html/
ENV PHP_INI_FILE /usr/local/etc/php/php.ini
ENV DBHOST mysql
ENV DBUSER nedi
ENV DBPASSWORD dbpa55
ENV DBNAME nedi

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
    rrdtool\
    libsocket6-perl \
    cpanminus\
    libdbd-mysql-perl\
    php5-mysql\
    php5-snmp\
    php5-gd\
    php5-mcrypt\
    && rm -rf /var/lib/apt/lists/*


 # Configure apache and required PHP modules
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-install mysqli && \
  #  docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include && \
  #  docker-php-ext-install gd && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install gettext && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
  #  docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu && \
  #  docker-php-ext-install gmp && \
  # docker-php-ext-install mcrypt && \
    docker-php-ext-install pcntl && \
  #  docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    # docker-php-ext-install ldap && \
    echo ". /etc/environment" >> /etc/apache2/envvars && \
    a2enmod rewrite
# 
COPY php.ini /usr/local/etc/php/
# 
 ENV NEDI_SOURCE http://www.nedi.ch/pub
 ENV NEDI_VERSION 1.6C
# 
 RUN cpanm \
       Net::SNMP\
       Net::Telnet\
       Algorithm::Diff\
 #      DBD::MySQL\
       DBI\
 #RUN cpanm RRDs
       Socket6\
       LWP::UserAgent\
       Net::DNS::Resolver\
       Net::NTP\
       IO::Tty
 #RUN cpanm libnet
# 
# 
 ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".tgz /tmp/
 RUN mkdir /var/nedi &&\
       tar -xvf /tmp/nedi-"$NEDI_VERSION".tgz --directory /var/nedi &&\
       chown -R www-data:www-data /var/nedi &&\
       chmod 775 /var/nedi/html/log/ &&\
       ln -s /var/nedi/nedi.conf /etc/nedi.conf &&\
      sed -i -e "s/^upload_max_filesize.*/upload_max_filesize = 2G/"  "${PHP_INI_FILE}" &&\
      sed -i -e "s/^post_max_size.*/post_max_size = 1G/"  "${PHP_INI_FILE}"&&\
      sed -i s/dbhost\t localhost/dbhost \t"${DBHOST}"/g /var/nedi/nedi.conf &&\
      cat /var/nedi/nedi.conf | grep dbhost 
      # sed -i "s/dbuser \"nedi/dbuser=\"${DBUSER}/g" /var/nedi/nedi.conf &&\
      # sed -i "s/dbpass=\"dbpa55=\"${DBPASSWORD}/g" /var/nedi/nedi.conf &&\
      # sed -i "s/dbname=\"nedi/dbname=\"${DBNAME}/g" /var/nedi/nedi.conf &&\
      # cat /var/nedi/nedi.conf | grep db &&\
      RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
      RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
      #CMD /var/nedi/nedi.pl -i u root F0ur

EXPOSE 443 80
 
