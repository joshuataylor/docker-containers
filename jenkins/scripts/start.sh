#!/bin/bash

##
# Copy files into specific directories.
##

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

##
# Rsyslog.
##

if [ -f '/etc/conf/rsyslog/rsyslog.conf' ]; then
  scp /etc/conf/rsyslog/rsyslog.conf /etc/rsyslog.conf
fi

##
# Jenkins.
##

JENKINS_DIR='/var/lib/jenkins'
if [ -d '/etc/conf/jenkins' ]; then
  mkdir -p $JENKINS_DIR
  FILES=/etc/conf/jenkins/*.xml*
  for FILE_DIR in $FILES; do
    FILE=$(basename $FILE_DIR)
    ln -sf $FILE_DIR $JENKINS_DIR/$FILE
  done
fi

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
