@echo on

set CUDA_ARGS=
if "%gpu_variant%"=="cuda-13" (
    set "CUDA_ARGS=-DUSE_CUDA=ON -DUSE_NVTX=ON"
)

mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE:STRING="Release" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -DR_LIB=OFF ^
    %CUDA_ARGS% ^
    "%SRC_DIR%"
if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

popd
