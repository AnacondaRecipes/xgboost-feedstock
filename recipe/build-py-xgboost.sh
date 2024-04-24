#!/bin/bash

${PYTHON} -m pip install --no-deps --no-build-isolation . -vv --config-settings use_system_libxgboost=True
