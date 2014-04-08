#!/bin/bash

##
# Copy files into specific directories.
##

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
# Postfix config.
##
if [ ! -z "${HOSTNAME}" ]; then
    echo ${HOSTNAME} > /etc/mailname
fi

if [ ! -z "${ROOTMAIL}" ]; then
  sed -i "s/ROOTMAIL@EXAMPLE.COM/${ROOTMAIL}/g" /etc/aliases
  grep -q "${ROOTMAIL}" /etc/aliases >/dev/; RET=$?
  if [ ${RET} -gt 0 ]; then
    echo -e "root:\t${ROOTMAIL}" >> /etc/aliases
  fi
  /usr/sbin/postalias hash:/etc/aliases
fi

# Open relay. Wheee!
/usr/sbin/postconf -e "mynetworks=0.0.0.0/0"


##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
