#!/bin/bash

set -exuo pipefail

# CUDA configuration
CUDA_ARGS=""
if [[ "${gpu_variant:-none}" == cuda* ]]; then
    CUDA_ARGS="-DUSE_CUDA=ON -DUSE_NCCL=ON -DBUILD_WITH_SHARED_NCCL=ON -DUSE_NVTX=ON"
fi

mkdir -p build-target
pushd build-target
  cmake ${CMAKE_ARGS} \
    -GNinja \
    -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    ${CUDA_ARGS} \
    "${SRC_DIR}"
  cmake --build . --target install --config Release
popd
