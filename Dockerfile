FROM ubuntu:16.04
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    gperf \
    ccache \
    doxygen \
    dfu-util \
    device-tree-compiler \
    python3-ply \
    python3-pip \
    python3-setuptools \
    xz-utils \
    file \
    make

RUN pip3 install -r https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/master/scripts/requirements.txt
RUN wget https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/0.9.2/zephyr-sdk-0.9.2-setup.run -O /tmp/zephyr-sdk-0.9.2-setup.run && \
    /tmp/zephyr-sdk-0.9.2-setup.run --target /opt/zephyr-sdk/
