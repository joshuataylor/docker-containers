#! /bin/sh

# Name: permissions.sh
# Author: Nick Schuch (nick@pnx.com.au)
# Comment: This is a script to enforce permissions best practices.

BASE='/var/www'
USER='deployer'
GROUP='www-data'

setPermissions() {
  # Public files.
  chown -R ${USER}:${GROUP} ${BASE}/shared/files
  find ${BASE}/shared/files -type d -exec chmod 2775 {} \;
  find ${BASE}/shared/files -type f -exec chmod 664 {} \;

  # Private files.
  chown -R ${USER}:${GROUP} ${BASE}/shared/private
  find ${BASE}/shared/private -type d -exec chmod 2775 {} \;
  find ${BASE}/shared/private -type f -exec chmod 664 {} \;

  # Make sure we have a paper trail.
  logger Permissions have been updated.
}

while true; do
  setPermissions
  sleep 15m
done
