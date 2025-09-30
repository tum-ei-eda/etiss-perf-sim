#!/bin/bash

set -e

# Get environmental variables
. $(dirname "${0}")/.env

# Setup ETISS
echo ""
echo "*** Installing ETISS ***"

cd ${EPS_ETISS}/PluginImpl
if [ ! -L SoftwareEvalLib ]; then
    echo " > Linking SoftwareEval Library to ETISS"
    ln -s ${EPS_ETISS_PLUGINS}/SoftwareEvalLib SoftwareEvalLib
fi

echo " > Applying hot-fixes to ETISS"
cp -r ${EPS_ETISS_HOTFIX}/include/etiss/* ${EPS_ETISS}/include/etiss
cp -r ${EPS_ETISS_HOTFIX}/src/* ${EPS_ETISS}/src

echo " > Installing..."
mkdir -p ${EPS_ETISS_BUILD}
cd ${EPS_ETISS_BUILD}
cmake -DCMAKE_BUILD_TYPE=Release -DETISS_BUILD_MANUAL_DOC=ON -DCMAKE_INSTALL_PREFIX:PATH=${EPS_ETISS_INSTALLED} ..
make -j$(nproc) install


# Setup simulator
echo ""
echo "*** Installing simulator ***"
cd ${EPS_SIM}
mkdir -p build
cd build
cmake -DETISS_DIR=${EPS_ETISS_INSTALLED}/lib/CMake/ETISS ..
make -j $(nproc)
