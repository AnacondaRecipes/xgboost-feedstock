#!/bin/bash

. activate "${BUILD_PREFIX}"

if [[ ${OSTYPE} == msys ]]; then
  # Just for now; should we handle slash fixing in conda-build?
  PREFIX=${PREFIX//\\//}
  SRC_DIR=${SRC_DIR//\\//}
fi

if [[ ${OSTYPE} == msys ]]; then
  LIBDIR=${PREFIX}/Library/mingw-w64/lib
  INCDIR=${PREFIX}/Library/mingw-w64/include
  BINDIR=${PREFIX}/Library/mingw-w64/bin
  SODIR=${BINDIR}
  XGBOOSTDSO=xgboost.dll
  EXEEXT=.exe
else
  LIBDIR=${PREFIX}/lib
  INCDIR=${PREFIX}/include
  BINDIR=${PREFIX}/bin
  SODIR=${LIBDIR}
  if [[ $(uname) == Darwin ]]; then
    XGBOOSTDSO=libxgboost.dylib
  else
    XGBOOSTDSO=libxgboost.so
  fi
  EXEEXT=
fi

mkdir -p ${LIBDIR} ${INCDIR}/xgboost ${BINDIR} || true
cp -f ${SRC_DIR}/lib/*.a ${LIBDIR}/  || true
cp ${SRC_DIR}/xgboost${EXEEXT} ${BINDIR}/
cp ${SRC_DIR}/lib/${XGBOOSTDSO} ${SODIR}/
cp -Rf ${SRC_DIR}/include/xgboost ${INCDIR}/
cp -Rf ${SRC_DIR}/rabit/include/rabit ${INCDIR}/xgboost/
cp -f ${SRC_DIR}/src/c_api/*.h ${INCDIR}/xgboost/
