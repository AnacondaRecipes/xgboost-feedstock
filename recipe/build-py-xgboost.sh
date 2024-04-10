#!/bin/bash

pushd ${SRC_DIR}/python-package
    ${PYTHON} -m pip install --no-deps --no-build-isolation . -vv
popd
