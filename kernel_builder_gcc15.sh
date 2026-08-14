#!/bin/bash


GCC64="/tmp/optane/gcc/arm-gnu-toolchain-15.3.rel1-x86_64-aarch64-none-linux-gnu"
GCC32="/tmp/optane/gcc/arm-gnu-toolchain-15.3.rel1-x86_64-arm-none-linux-gnueabihf"
export PATH="$PREFIX$GCC64/bin:$PREFIX$GCC32/bin:$PATH"

export CROSS_COMPILE=aarch64-none-linux-gnu-
export ARCH=arm64
export SUBARCH=arm64
export HEADER_ARCH=arm64

#rm -rf out
mkdir out
#rm -rf error.log
#make O=out clean 
#make mrproper

export CROSS_COMPILE=aarch64-none-linux-gnu-
echo $PATH

ARCH=arm64 scripts/kconfig/merge_config.sh -O out arch/arm64/configs/libra_defconfig libra_defconfig_append_gcc > /dev/null 2>&1 


make -j24 ARCH=arm64 O=out SUBARCH=arm64 O=out \
	CC="ccache aarch64-none-linux-gnu-gcc" \
        LD="aarch64-none-linux-gnu-ld" \
        AR="aarch64-none-linux-gnu-ar" \
        AS="aarch64-none-linux-gnu-as" \
        NM="aarch64-none-linux-gnu-nm" \
        CROSS_COMPILE_ARM32="ccache arm-none-linux-gnueabihf-" \
        OBJCOPY="aarch64-none-linux-gnu-objcopy" \
        OBJDUMP="aarch64-none-linux-gnu-objdump" \
        STRIP="aarch64-none-linux-gnu-strip" \
        CROSS_COMPILE="ccache aarch64-none-linux-gnu-"
#	KBUILD_BUILD_USER="$(git rev-parse --short HEAD | cut -c1-7)" \
#	KBUILD_BUILD_HOST="$(git symbolic-ref --short HEAD)" \
#echo $LD

# for i in $(ls patches_los16/) ; do patch -Np1 < patches_los16/$i ; done
