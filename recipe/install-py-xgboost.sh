#!/bin/bash

pushd ${SRC_DIR}/python-package
  if [[ ${OSTYPE} == msys ]]; then
    ${PYTHON//\\//} setup.py install --use-system-libxgboost --single-version-externally-managed --record=record.txt
  else
    ${PYTHON} setup.py install --use-system-libxgboost --single-version-externally-managed --record=record.txt
  fi
popd
