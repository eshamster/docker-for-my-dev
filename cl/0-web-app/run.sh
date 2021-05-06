#!/bin/bash

set -eux

base_dir=$(dirname ${0})
. "${1:-${base_dir}/setenv}"

if [ ! -d "${base_dir}/dotfiles" ]; then
  (
    cd ${base_dir}
    git clone git@github.com:eshamster/dotfiles.git
  )
fi

no_cache=
if [ ${2:-0} -eq 1 ]; then
  no_cache="--no-cache"
fi

docker rmi $(docker images | awk '/^<none>/ { print $3 }') || echo "ignore rmi error"
docker rm `docker ps -a -q` || echo "ignore rm error"

docker build ${no_cache} -t cl .
docker run --name=${RUN_NAME} \
  -p ${HOST_PORT}:${GUEST_PORT} \
  -e "OPEN_PORT=${GUEST_PORT}" \
  -e "HOST_PORT=${HOST_PORT}" \
  -v ${VOLUME}:/root/work/lisp \
  -v "$(pwd)/dotfiles/others/cl-devel2":/root/.emacs.d/site-lisp/custom \
  -it cl /bin/sh
