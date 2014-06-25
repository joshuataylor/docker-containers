#!/bin/bash

# Name: proxy.sh
# Author: Nick Schuch (nick@pnx.com.au)
# Description: Provides proxy configuration to tunnel through the Docker container environments.

##
# Variables.
##

# Commented variables are set by Docker configuration.
# DOMAIN='ci-slave1.local'
# POTENTIAL_PORTS='8983 80'
# DOCKER_HOST
DOCKER_BIN='docker'
NGINX_PROXY_DIR='/etc/nginx/sites-enabled'
NGINX_AUTH_DIR='/etc/nginx/auth'

##
# Helper functions.
##

# Creates a proxy nginx file.
proxyConf () {
  # Variables.
  PROXY_PROJECT=$1
  PROXY_DOMAIN=$2
  PROXY_TARGET=$3

  # Create the nginx proxy configuration.
cat > $NGINX_PROXY_DIR/$PROXY_DOMAIN << EOF
server {
  listen                    *:80;
  server_name               ${PROXY_DOMAIN};
  auth_basic                "Restricted";
  auth_basic_user_file      ${NGINX_AUTH_DIR}/${PROXY_PROJECT};
  index                     index.html index.htm index.php;
  access_log                /var/log/nginx/${PROXY_DOMAIN}.access.log;
  error_log                 /var/log/nginx/${PROXY_DOMAIN}.error.log;
  location / {
    proxy_pass              http://${PROXY_TARGET};
    proxy_set_header        Host \$host;
    proxy_set_header        X-Real-IP \$remote_addr;
    proxy_set_header        X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_connect_timeout   150;
    proxy_send_timeout      100;
    proxy_read_timeout      100;
    proxy_buffers           4 32k;
    client_max_body_size    8m;
    client_body_buffer_size 128k;
  }
}
EOF

  # Create the httpauth file based on the project.
  htpasswd -cb $NGINX_AUTH_DIR/$PROXY_PROJECT $PROXY_PROJECT "${PROXY_PROJECT}!@#"
}

# Helper function to clean
proxyClean () {
  mkdir -p $NGINX_PROXY_DIR
  mkdir -p $NGINX_AUTH_DIR
  rm -f $NGINX_PROXY_DIR/*
  rm -f $NGINX_AUTH_DIR/*
}

# Helper function to build proxy configs.
proxyBuild () {
  # Get the containers.
  CONTAINERS=`${DOCKER_BIN} ps | cut -d ' ' -f 1 | grep -v 'CONTAINER'`
  for CONTAINER in $CONTAINERS; do
    # Get the unique ID of the container.
    CONTAINER_ID=`echo ${CONTAINER} | cut -d ' ' -f 1`
    CONTAINER_NAME=`${DOCKER_BIN} inspect --format '{{.Name}}' ${CONTAINER_ID}`

    # Clean up the URL's a little.
    SUB=`echo ${CONTAINER_NAME} | sed "s/\///g" | sed "s/_/-/g"`
    PROJECT=`echo ${SUB}| cut -d '-' -f 1`

    # We also want to get the internal IP and the PORT we need to proxy to.
    IP=`${DOCKER_BIN} inspect --format '{{.NetworkSettings.IPAddress}}' ${CONTAINER_ID}`
    PORTS=`${DOCKER_BIN} inspect --format '{{.Config.ExposedPorts}}' ${CONTAINER_ID}`

    # We determine the port we forward to by picking port 80 as prefered and work our way down.
    PORT=""
    for POTENTIAL_PORT in $POTENTIAL_PORTS; do
      COUNT=`echo ${PORTS} | grep ${POTENTIAL_PORT} | wc -l`
      if [ "${COUNT}" -gt "0" ]; then
        PORT=$POTENTIAL_PORT
      fi
    done

    # If we don't have a port, we don't proxy it.
    if [ ! $PORT ]; then
      continue
    fi

    # Create the proxy record.
    proxyConf $PROJECT "${SUB}.${DOMAIN}" "${IP}:${PORT}"
  done
}

# Run the proxy builder in a daemon like mode.
while true; do
  # Rebuild the proxy.
  proxyClean
  proxyBuild

  # Restart the reverse proxy server.
  service nginx reload

  # Put some distance between each run.
  sleep 1m
done
