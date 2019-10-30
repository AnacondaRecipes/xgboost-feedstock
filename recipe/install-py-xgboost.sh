#!/bin/bash

. activate "${PREFIX}"

pushd ${SRC_DIR}/python-package
  ${PYTHON} -m pip install --no-deps -vv .
popd
