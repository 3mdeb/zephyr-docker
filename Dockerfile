FROM ubuntu:16.04
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
    git \
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
    make \
    wget

RUN pip3 install -r https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/{{ZEPHYR_VER}}/scripts/requirements.txt

RUN wget https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/{{SDK_VER}}/zephyr-sdk-{{SDK_VER}}-setup.run -O /tmp/zephyr-sdk-{{SDK_VER}}-setup.run && \
    chmod +x /tmp/zephyr-sdk-{{SDK_VER}}-setup.run && \
    /tmp/zephyr-sdk-{{SDK_VER}}-setup.run --target /opt/zephyr-sdk/

RUN apt-get install -y --no-install-recommends curl

RUN curl 'https://www.segger.com/downloads/jlink/JLink_Linux_V622d_x86_64.deb' --data 'accept_license_agreement=accepted&submit=Download+software' --output /tmp/JLink_Linux_V622d_x86_64.deb && \
    dpkg -i /tmp/JLink_Linux_V622d_x86_64.deb

RUN useradd -ms /bin/bash build && \
    usermod -aG sudo build

USER build
WORKDIR /home/build

# compile cmake
RUN mkdir $HOME/cmake && cd $HOME/cmake && \
    wget https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.sh && \
    yes | sh cmake-3.8.2-Linux-x86_64.sh | cat

RUN wget https://www.nordicsemi.com/eng/nordic/download_resource/51505/27/8654629/94917 -O /tmp/nRF5x-Command-Line-Tools_9_7_2_Linux-x86_64.tar && \
    tar xvf /tmp/nRF5x-Command-Line-Tools_9_7_2_Linux-x86_64.tar -C /home/build

ENV PATH="/home/build/cmake/cmake-3.8.2-Linux-x86_64/bin:/home/build/nrfjprog:/home/build/mergehex:${PATH}"
ENV ZEPHYR_GCC_VARIANT zephyr
ENV ZEPHYR_SDK_INSTALL_DIR /opt/zephyr-sdk/
