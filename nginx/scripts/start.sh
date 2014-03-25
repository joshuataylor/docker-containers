#!/bin/bash

##
# Ensure we have good permissions.
##

chmod -R 775 /etc/nginx/site-enabled
chmod -R 775 /etc/nginx/auth

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

##
# Rsyslog.
##

if [ -f '/etc/conf/rsyslog/rsyslog.conf' ]; then
  scp /etc/conf/rsyslog/rsyslog.conf /etc/rsyslog.conf
fi

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
