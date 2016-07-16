#!/bin/bash

set -eu

docker rmi $(docker images | awk '/^<none>/ { print $3 }') || echo "ignore rmi error"
docker rm `docker ps -a -q` || echo "ignore rm error"

name=${1:-cl}
host_port=${2:-19807}
mongo_volume=${3:-/data/mongo/cl-bot}

docker build -t cl .
docker run --name=${1:-cl} -p ${host_port}:16896 -e "OPEN_PORT=16896" -e "HOST_PORT=${host_port}" -v ${HOME}/work/lisp:/home/dev/work/lisp -v ${mongo_volume}:/data/mongo -it cl /bin/bash
