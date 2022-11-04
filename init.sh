#!/bin/bash

SDK_VER=${SDK_VER:-0.9.2}
ZEPHYR_VER=${ZEPHYR_VER:-master}

cat Dockerfile | \
  sed "s/{{SDK_VER}}/$SDK_VER/g" | \
  sed "s/{{ZEPHYR_VER}}/$ZEPHYR_VER/g" | \
  docker build -t 3mdeb/zephyr-docker -

if [ $? -ne 0 ]; then
    echo "ERROR: Unable to build container"
    exit 1
fi

if [ ! -d "zephyr" ]; then
  git clone https://github.com/zephyrproject-rtos/zephyr.git
fi

docker run --rm -t -i --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD/zephyr:/home/build/zephyr 3mdeb/zephyr-docker:0.9.2.1 /bin/bash
