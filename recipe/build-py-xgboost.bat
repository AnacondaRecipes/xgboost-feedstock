@echo on
%PYTHON% -m pip install --no-deps --no-build-isolation ./python-package -vv --config-settings use_system_libxgboost=True
