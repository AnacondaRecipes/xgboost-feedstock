#!/bin/bash

set -exuo pipefail

# xgboost 3.4.x switched the Python build backend to scikit-build-core.
# Regenerate python-package/pyproject.toml from the upstream template with
# no NCCL dependency declared (libxgboost/nccl are supplied by the conda
# packages, not pip) so `pip check` passes. Mirrors conda-forge's approach.
${PYTHON} ${SRC_DIR}/ops/script/pypi_variants.py --use-suffix=na --require-nccl-dep=na

# wheel.cmake=false skips the CMake configure/build step entirely (we
# already ship libxgboost via the separate `libxgboost` output; the
# runtime loader in xgboost/libpath.py falls back to sys.base_prefix/lib).
# wheel.platlib=false keeps the resulting wheel a pure-Python (non
# platform-tagged) wheel since no compiled artifact is bundled.
${PYTHON} -m pip install --no-deps --no-build-isolation ./python-package -vv \
    --config-settings=wheel.cmake=false \
    --config-settings=wheel.platlib=false
