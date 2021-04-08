#!/bin/sh

# Create user
sed -i 's#dbpa55#'${MYSQL_ROOT_PASSWORD}'#g' /var/local/nedi/nedi.conf
/var/local/nedi/install.exp $DBUSER $MYSQL_ROOT_PASSWORD

