@echo on

set CUDA_ARGS=
REM Use substring match to support future CUDA versions (cuda-13, cuda-14, etc.)
REM NCCL is not available on Windows, so only USE_CUDA and USE_NVTX are enabled
if "%gpu_variant:~0,4%"=="cuda" (
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
