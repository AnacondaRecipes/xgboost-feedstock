@echo on

REM xgboost 3.4.x switched the Python build backend to scikit-build-core.
REM Regenerate python-package/pyproject.toml from the upstream template with
REM no NCCL dependency declared (libxgboost/nccl are supplied by the conda
REM packages, not pip) so `pip check` passes. Mirrors conda-forge's approach.
%PYTHON% %SRC_DIR%/ops/script/pypi_variants.py --use-suffix=na --require-nccl-dep=na
if errorlevel 1 exit 1

REM wheel.cmake=false skips the CMake configure/build step entirely (we
REM already ship libxgboost via the separate `libxgboost` output; the
REM runtime loader in xgboost/libpath.py falls back to sys.base_prefix/lib).
REM wheel.platlib=false keeps the resulting wheel a pure-Python (non
REM platform-tagged) wheel since no compiled artifact is bundled.
%PYTHON% -m pip install --no-deps --no-build-isolation ./python-package -vv ^
    --config-settings=wheel.cmake=false ^
    --config-settings=wheel.platlib=false
if errorlevel 1 exit 1
