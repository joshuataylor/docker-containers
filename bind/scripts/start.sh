#!/bin/bash

##
# Bind.
##

# We swap out the DEV IP ADRESS so we can point *.dev to any IP we want.
if [ ! -z "${DEV_IP_ADDRESS}" ]; then
  sed "s/DEV_IP_ADDRESS/${DEV_IP_ADDRESS}/" /etc/bind/db.dev
else
  sed "s/DEV_IP_ADDRESS/127.0.0.1/" /etc/bind/db.dev
fi

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
