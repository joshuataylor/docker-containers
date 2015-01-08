#!/bin/bash

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

  # Add any extra root key fragments.
  for file in /etc/conf/sshd/root_authorized_keys_*; do \
    test -e "${file}" && cat "${file}" >> /root/.ssh/authorized_keys; \
  done 2>/dev/null

  chmod 400 /root/.ssh/authorized_keys
  chown root:root -R /root/.ssh
fi

##
# Rsyslog.
##

if [ -f '/etc/conf/rsyslog/rsyslog.conf' ]; then
  cp /etc/conf/rsyslog/rsyslog.conf /etc/rsyslog.conf
fi

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
