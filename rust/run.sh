#!/bin/bash

set -eu

name=my-rust-dev

docker build -t ${name} .
# docker run --rm --mount type=bind,src=/home/esh/work/rust,dst=/root/work -it ${name}:latest /bin/bash
docker run --rm -v /home/esh/work/rust:/root/work -it ${name}:latest /bin/bash
