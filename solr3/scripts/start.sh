#!/bin/bash

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

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
