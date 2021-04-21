@REM ------------------------------
@REM script for building with msys2
@REM ------------------------------
@REM copy "%RECIPE_DIR%\build.sh" .
@REM set PREFIX=%PREFIX:\=/%
@REM set SRC_DIR=%SRC_DIR:\=/%
@REM set MSYSTEM=MINGW%ARCH%
@REM set MSYS2_PATH_TYPE=inherit
@REM set CHERE_INVOKING=1
@REM bash -lc "./build.sh"
@REM if errorlevel 1 exit 1
@REM exit 0
@REM ------------------------------

mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE:STRING="Release" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -DR_LIB=OFF ^
    "%SRC_DIR%"
if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

popd
