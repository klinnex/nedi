FROM php:7.0-apache
MAINTAINER Klinnex

ENV APACHE_DOCUMENT_ROOT /var/nedi/html/
ENV PHP_INI_FILE /usr/local/etc/php/php.ini
ENV DBHOST mysql
ENV DBUSER root
ENV DBNAME nedi


#Install of dependency
RUN rm /etc/apt/preferences.d/no-debian-php &&\
    apt-get update &&\
    apt-get install -y\
    libnet-snmp-perl\
    expect\
    libcrypt-rijndael-perl\
    libcrypt-hcesha-perl\
    libcrypt-des-perl\
    libdigest-hmac-perl\
    libio-pty-perl\
    libnet-telnet-perl\
    libalgorithm-diff-perl\
    librrds-perl\
    rrdtool\
    vim\
    mysql-client\
    cron\
    libsocket6-perl \
    cpanminus\
    libdbd-mysql-perl\
    libsnmp-dev\
    libsnmp30\
    php-mysql\
    php-snmp\
    php-gd\
    php-mcrypt\
    libfreetype6-dev\
    libjpeg62-turbo-dev\
    && rm -rf /var/lib/apt/lists/*


 # Configure apache and required PHP modules
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-install mysqli && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install gettext && \
    docker-php-ext-install snmp &&\
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
 ENV NEDI_VERSION 1.7C
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
 ADD     "$NEDI_SOURCE"/nedi-"$NEDI_VERSION".pkg /tmp/
 RUN mkdir /var/nedi &&\
       tar -xvf /tmp/nedi*.pkg --directory /var/nedi &&\
       chown -R www-data:www-data /var/nedi &&\
       chmod 775 /var/nedi/html/log/ &&\
       ln -s /var/nedi/nedi.conf /etc/nedi.conf &&\
      sed -i -e "s/^upload_max_filesize.*/upload_max_filesize = 2G/"  "${PHP_INI_FILE}" &&\
      sed -i -e "s/^post_max_size.*/post_max_size = 1G/"  "${PHP_INI_FILE}"&&\
      sed -i '/dbhost/s/localhost/'"${DBHOST}"'/g' /var/nedi/nedi.conf &&\
      sed -i '/dbuser/s/nedi/'"${DBUSER}"'/g' /var/nedi/nedi.conf &&\
      sed -i '/dbpass/s/dbpass55/'${MYSQL_ROOT_PASSWORD}'/g' /var/nedi/nedi.conf &&\
      sed -i '/dbname/s/nedi/'"${DBNAME}"'/g' /var/nedi/nedi.conf &&\ 
      # cat /var/nedi/nedi.conf | grep db &&\
      sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf &&\
      sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
     # CMD /var/nedi/nedi.pl -i u root getenv(\"MYSQL_ENV_MYSQL_ROOT_PASSWORD\") && bash
     #ENTRYPOINT
     COPY docker-entrypoint.sh /usr/local/bin/
     RUN ln -s /usr/local/bin/docker-entrypoint.sh / &&\
     chmod +x /usr/local/bin/docker-entrypoint.sh
     #ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
WORKDIR /var/nedi/
EXPOSE 443 80 514
 
