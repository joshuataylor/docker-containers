#!/bin/bash

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

supervisord -n -c /etc/supervisord.conf &

##
# Travis.
##

travis run --skip-version-check --skip-completion-check env before_script script
