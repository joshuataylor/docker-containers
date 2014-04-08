#!/bin/sh
# init-like script for the postfix container

# Run tasks as jobs where possible, so we can wait on them.
/usr/sbin/rsyslogd -n &
/usr/sbin/sshd -D &
/usr/sbin/postfix start # postfix won't get waited on.

wait
