#!/bin/bash

##
# Bind.
##

# We swap out the DEV IP ADRESS so we can point *.dev to any IP we want.
DEV_DB="/etc/bind/db.dev"
if [ ! -z "${DEV_IP_ADDRESS}" ]; then
  DEV=$(sed "s/DEV_IP_ADDRESS/${DEV_IP_ADDRESS}/" ${DEV_DB})
else
  DEV=$(sed "s/DEV_IP_ADDRESS/127.0.0.1/" ${DEV_DB})
fi
echo $DEV > /etc/bind/db.dev

##
# Supervisord.
##

supervisord -n -c /etc/supervisord.conf
