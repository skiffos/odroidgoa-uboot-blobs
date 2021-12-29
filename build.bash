#!/bin/bash
set -eo pipefail

if [ ! -f ./u-boot/Makefile ]; then
    git submodule update --init
fi

TOOLCHAIN=host-toolchain
if [ ! -d ./${TOOLCHAIN} ]; then
    echo "Downloading toolchain..."
    if [ ! -f ./toolchain.tar.xz ]; then
        wget -O ./toolchain.tar.xz \
             https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
    fi
    mkdir -p ./${TOOLCHAIN}
    tar -C ./${TOOLCHAIN} --strip-components=1 -xf toolchain.tar.xz
fi

cd ./u-boot
./make.sh odroidgoa
cp ./sd_fuse/idbloader.img ../idbloader.img
cp ./sd_fuse/trust.img ../trust.img
cp ./sd_fuse/uboot.img ../uboot.img
