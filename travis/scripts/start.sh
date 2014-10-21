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

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
