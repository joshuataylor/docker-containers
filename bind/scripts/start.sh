#!/bin/bash

##
# Bind.
##

# We swap out the DEV IP ADRESS so we can point *.dev to any IP we want.
DEV_DB="/etc/bind/db.dev"
if [ ! -z "${DEV_IP_ADDRESS}" ]; then
  sed -i.bak s/DEV_IP_ADDRESS/${DEV_IP_ADDRESS}/g ${DEV_DB}
else
  sed -i.bak s/DEV_IP_ADDRESS/127.0.0.1/g ${DEV_DB}
fi

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
