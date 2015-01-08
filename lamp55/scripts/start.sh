#!/bin/bash

##
# Copy files into specific directories.
##

##
# Apache.
##

if [ -f '/etc/conf/apache/apache2.conf' ]; then
  cp /etc/conf/apache/apache2.conf /etc/apache2/apache2.conf
fi

if [ -f '/etc/conf/apache/vhost.conf' ]; then
  rm -f /etc/apache2/sites-enabled/*
  cp /etc/conf/apache/vhost.conf /etc/apache2/sites-available/drupal.conf
  ln -s /etc/apache2/sites-available/drupal.conf /etc/apache2/sites-enabled/drupal.conf
fi

##
# PHP.
##

if [ -f '/etc/conf/php/php.ini' ]; then
  cp /etc/conf/php/php.ini /etc/php5/apache2/php.ini
  cp /etc/conf/php/php.ini /etc/php5/cli/php.ini
fi

##
# Mysql.
##

if [ -f '/etc/conf/mysql/my.cnf' ]; then
  cp /etc/conf/mysql/my.cnf /etc/mysql/my.cnf
fi
chown -R mysql:mysql /var/lib/mysql

##
# Cron.
##

if [ -d '/etc/conf/cron' ]; then
  cp /etc/conf/cron/* /etc/cron.d/
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
  mkdir -m 0700 -p /root/.ssh
  cp /etc/conf/sshd/root_authorized_keys /root/.ssh/authorized_keys

  chmod 400 /root/.ssh/authorized_keys
  chown root:root -R /root/.ssh
fi

# Deployer user.
if [ -f '/etc/conf/sshd/deployer_authorized_keys' ]; then
  mkdir -m 0700 -p /home/deployer/.ssh
  cp /etc/conf/sshd/deployer_authorized_keys /home/deployer/.ssh/authorized_keys

  # Add any extra deployer key fragments.
  for file in /etc/conf/sshd/deployer_authorized_keys_*; do
    cat "${file}" >> /home/deployer/.ssh/authorized_keys
  done

  # Change file permissions.
  chmod 400 /home/deployer/.ssh/authorized_keys
  chown deployer:deployer -R /home/deployer/.ssh
fi

##
# Permissions.
##

chown -R deployer:www-data /var/www

##
# Rsyslog.
##

if [ -f '/etc/conf/rsyslog/rsyslog.conf' ]; then
  cp /etc/conf/rsyslog/rsyslog.conf /etc/rsyslog.conf
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
