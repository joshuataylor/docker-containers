#!/bin/bash

CURRENT=`pwd`

for CONTAINER in $(ls -d -- *)
do
  cd ${CURRENT}/${CONTAINER} && docker build -t previousnext/${CONTAINER} .
done

# Clean up the old diff's and containers.
docker rm `docker ps --notrunc -a -q`

