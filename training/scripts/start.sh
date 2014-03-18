#!/bin/bash

##
# Install Drupal.
##

DRUPAL_DB="drupal"
MYSQL_PASSWORD=`pwgen -c -n -1 12`
DRUPAL_PASSWORD=`pwgen -c -n -1 12`

# Logging. 
echo mysql root password: $MYSQL_PASSWORD
echo drupal password: $DRUPAL_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $DRUPAL_PASSWORD > /drupal-db-pw.txt

# Install.
/usr/bin/mysqld_safe & 
sleep 10s
mysqladmin -u root password $MYSQL_PASSWORD 
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE ${DRUPAL_DB};"
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON ${DRUPAL_DB}.* TO 'drupal'@'localhost' IDENTIFIED BY '${DRUPAL_PASSWORD}';"
mysql -uroot -p$MYSQL_PASSWORD -e "FLUSH PRIVILEGES;"
cd /var/www/
drush site-install standard -y --account-name=admin --account-pass=admin --db-url="mysqli://drupal:${DRUPAL_PASSWORD}@localhost:3306/${DRUPAL_DB}"
killall mysqld
sleep 10s

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
