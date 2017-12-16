zephyr-docker
=============

This repository contains Docker container of development environment for Zephyr
Project RTOS.

In addition container have tools for Nordic nRF52 development.

Usage
-----

## From Docker hub

```
docker pull 3mdeb/zephyr-docker
```

## From source

```
git clone https://github.com/3mdeb/zephyr-docker.git
cd zephyr-docker
ZEPHYR_VER=master SDK_VER=0.9.2 ./init.sh
```

Of course if SDK would be updated and installation method would not change you
should change `SDK_VER` stage accordingly.

`ZEPHYR_VER` can be any release e.g. `zephyr-v1.10.0`.

If no environment variables defined default from `init.sh` would be taken
(`SDK_VER`: 0.9.2, `ZEPHYR_VER`: master).

## Building and flashing

```
cd ~/zephyr
cd samples/bluetooth/beacon
mkdir build && cd build
cmake -DBOARD=nrf52_pca10040 ..
make
make flash
```
