#!/bin/bash

##
# Copy files into specific directories.
##

##
# Apache.
##

if [ -f '/etc/conf/apache/apache2.conf' ]; then
  scp /etc/conf/apache/apache2.conf /etc/apache2/apache2.conf
fi

if [ -f '/etc/conf/apache/vhost.conf' ]; then
  rm -f /etc/apache2/sites-enabled/*
  scp /etc/conf/apache/vhost.conf /etc/apache2/sites-available/drupal.conf
  ln -s /etc/apache2/sites-available/drupal.conf /etc/apache2/sites-enabled/drupal.conf
fi

##
# PHP.
##

if [ -f '/etc/conf/php/php.ini' ]; then
  scp /etc/conf/php/php.ini /etc/php5/apache2/php.ini
  scp /etc/conf/php/php.ini /etc/php5/cli/php.ini
fi

##
# Mysql.
##

if [ -f '/etc/conf/mysql/my.cnf' ]; then
  scp /etc/conf/mysql/my.cnf /etc/mysql/my.cnf
fi
chown -R mysql:mysql /var/lib/mysql

##
# Cron.
##

if [ -d '/etc/conf/cron' ]; then
  scp /etc/conf/cron/* /etc/cron.d/
fi

##
# SSHD.
##

# Global ssh config.
if [ -d '/etc/conf/sshd' ]; then
  rsync -avz /etc/conf/sshd/* /etc/ssh/
fi

# Root user.
if [ -f '/etc/conf/sshd/root_authorized_keys' ]; then
  mkdir -p /root/.ssh
  scp /etc/conf/sshd/root_authorized_keys /root/.ssh/authorized_keys
  chmod 400 /root/.ssh/authorized_keys
  chown root:root -R /root/.ssh
fi

# Deployer user.
if [ -f '/etc/conf/sshd/deployer_authorized_keys' ]; then
  mkdir -p /home/deployer/.ssh
  scp /etc/conf/sshd/deployer_authorized_keys /home/deployer/.ssh/authorized_keys
  chmod 400 /home/deployer/.ssh/authorized_keys
  chown deployer:deployer -R /home/deployer/.ssh
fi

# AWS credentials.
if [ -f '/etc/conf/aws/credentials' ]; then
  mkdir -p /home/deployer/.aws
  cp /etc/conf/aws/credentials /home/deployer/.aws/credentials
  chmod 750 /home/deployer/.aws
  chmod 640 /home/deployer/.aws/credentials
  chown deployer:deployer -R /home/deployer/.aws
  mkdir -p /var/www/.aws
  cp /etc/conf/aws/credentials /var/www/.aws/credentials
  chmod 750 /var/www/.aws
  chmod 640 /var/www/.aws/credentials
  chown deployer:www-data -R /var/www/.aws
fi

##
# Permissions.
##

chown -R deployer:www-data /var/www

##
# Rsyslog.
##

if [ -f '/etc/conf/rsyslog/rsyslog.conf' ]; then
  scp /etc/conf/rsyslog/rsyslog.conf /etc/rsyslog.conf
fi

##
# Nullmailer.
##

if [ ! -z "${NULLMAILER_REMOTE}" ]; then
  echo ${NULLMAILER_REMOTE} > /etc/nullmailer/remotes
fi
mkfifo /var/spool/nullmailer/trigger
chmod 0622 /var/spool/nullmailer/trigger
chown mail:root /var/spool/nullmailer/trigger

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
