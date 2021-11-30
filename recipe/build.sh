#!/bin/bash

set -exuo pipefail

# ppc64le does not set this in the compiler packages, yet.
if [[ ${target_platform} == linux-ppc64le ]]; then
  CMAKE_ARGS="-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_FIND_ROOT_PATH=${PREFIX};${BUILD_PREFIX}/${HOST}/sysroot \
    -DCMAKE_INSTALL_LIBDIR=lib"
fi

mkdir -p build-target
pushd build-target
  cmake ${CMAKE_ARGS} \
    -GNinja \
    -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    "${SRC_DIR}"
  ninja
popd
