#!/bin/bash

##
# Environment.
##
if [ -f '/etc/conf/environment/environment' ]; then
  . /etc/conf/environment/environment
  cp /etc/conf/environment/environment /etc/environment
fi

##
# SSHD.
##

# Global ssh config.
if [ -d '/etc/conf/sshd' ]; then
  rsync -avz /etc/conf/sshd/* /etc/ssh/
fi

##
# Rsyslog.
##

if [ -d '/etc/conf/rsyslog' ]; then
  scp /etc/conf/rsyslog/* /etc/
fi

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
