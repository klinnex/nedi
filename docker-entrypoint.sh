#!/bin/sh

# Create user
sed -i 's#dbpa55#'${MYSQL_ROOT_PASSWORD}'#g' /var/local/nedi/nedi.conf
CONTAINER_ALREADY_STARTED="/var/local/nedi/already_first_start.pid"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # YOUR_JUST_ONCE_LOGIC_HERE
sleep 60
expect /var/local/nedi/install.exp $DBUSER $MYSQL_ROOT_PASSWORD
sleep 3600
else
echo "Already first setup"
sleep 3600
fi
