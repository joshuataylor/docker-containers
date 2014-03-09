#!/bin/bash

##
# Copy files into specific directories.
##

##
# Apache.
##

rm -f /etc/apache2/sites-enabled/*
scp /etc/conf/apache/vhost.conf /etc/apache2/sites-available/drupal
ln -s /etc/apache2/sites-available/drupal /etc/apache2/sites-enabled/drupal

##
# PHP.
##

scp /etc/conf/php/php.ini /etc/php5/apache2/php.ini
scp /etc/conf/php/php.ini /etc/php5/cli/php.ini

##
# Mysql.
##

scp /etc/conf/mysql/my.cnf /etc/mysql/my.cnf
chown -R mysql:mysql /var/lib/mysql

##
# Cron.
##

scp /etc/conf/cron/* /etc/cron.d/

##
# SSHD.
##

# Global ssh config.
scp /etc/conf/sshd/sshd_config /etc/ssh/sshd_config

# Root user.
mkdir -p /root/.ssh
scp /etc/conf/sshd/root_authorized_keys /root/.ssh/authorized_keys
chmod 400 /root/.ssh/authorized_keys
chown root:root -R /root/.ssh

# Deployer user.
mkdir -p /home/deployer/.ssh
scp /etc/conf/sshd/deployer_authorized_keys /home/deployer/.ssh/authorized_keys
chmod 400 /home/deployer/.ssh/authorized_keys
chown deployer:deployer -R /home/deployer/.ssh

##
# Permissions.
##

chown -R deployer:www-data /var/www

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
