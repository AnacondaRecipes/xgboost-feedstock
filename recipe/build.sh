#!/bin/bash

# http://xgboost.readthedocs.io/en/latest/build.html

if [[ ${OSTYPE} == msys ]]; then
  if [[ "${ARCH}" == "32" ]]; then
    # SSE2 is used and we get called from MSVC
    # CPython so 32-bit GCC needs realignment.
    export CC="gcc -mstackrealign"
    export CXX="g++ -mstackrealign"
  fi
  # cp make/mingw64.mk config.mk
fi

# XGBoost uses its own compilation flags.
echo "ADD_LDFLAGS = ${LDFLAGS}" >> config.mk
echo "ADD_CFLAGS = ${CFLAGS}" >> config.mk

{
  cmake \
    -G "Unix Makefiles" \
    -D CMAKE_BUILD_TYPE:STRING="Release" \
    -D CMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON \
    -D CMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    "${SRC_DIR}"
} || {
  cat $SRC_DIR/CMakeFiles/CMakeOutput.log
  cat $SRC_DIR/CMakeFiles/CMakeError.log
  exit 1
}
make -j${CPU_COUNT}
