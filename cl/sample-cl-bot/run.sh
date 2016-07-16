#!/bin/bash

set -eu

. "${1:-$(dirname ${0})/setenv}"

docker rmi $(docker images | awk '/^<none>/ { print $3 }') || echo "ignore rmi error"
docker rm `docker ps -a -q` || echo "ignore rm error"

docker build -t cl .
docker run --name=${RUN_NAME} -p ${HOST_PORT}:16896 -e "OPEN_PORT=16896" -e "HOST_PORT=${HOST_PORT}" -v ${HOME}/work/lisp:/home/dev/work/lisp -v ${MONGO_VOLUME}:/data/mongo -it cl /bin/bash
