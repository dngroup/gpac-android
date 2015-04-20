#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd gpac

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--sysroot="$NDK_SYSROOT" \
--enable-pic \
--use-js=no \
--use-ft=no \
--use-zlib=no \
--use-jpeg=no \
--use-png=no \
--use-faad=no \
--use-mad=no \
--use-xvid=no \
--use-ffmpeg=no \
--use-ogg=no \
--use-vorbis=no \
--use-theora=no \
--use-openjpeg=no \
--use-a52=no \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS -DGPAC_ANDROID" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-cxxflags="$CXX_FLAGS" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
