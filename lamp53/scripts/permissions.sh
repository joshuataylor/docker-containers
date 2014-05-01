#! /bin/sh

# Name: permissions.sh
# Author: Nick Schuch (nick@pnx.com.au)
# Comment: This is a script to enforce permissions best practices.

BASE='/var/www'
USER='deployer'
GROUP='www-data'

setPermissions() {
  # Set all the permissions!
  chown -R ${USER}:${GROUP} ${BASE}/shared/files
  find ${BASE}/shared/files -type d -exec chmod 775 {} \;
  find ${BASE}/shared/files -type f -exec chmod 664 {} \;

  # Make sure we have a paper trail.
  logger Permissions have been updated.
}

while true; do
  setPermissions
  sleep 15m
done

