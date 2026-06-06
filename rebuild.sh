#!/bin/bash

set -e

. $(dirname "${0}")/.env

echo " > Re-Installing ETISS"
start=$(date +%s%N)
cd ${EPS_ETISS_BUILD}
cmake -DCMAKE_BUILD_TYPE=Release -DETISS_BUILD_MANUAL_DOC=ON -DCMAKE_INSTALL_PREFIX:PATH=${EPS_ETISS_INSTALLED} ..
make -j$(nproc) install
end=$(date +%s%N)
echo "Done rebuilding ETISS-PerfSim. Time spend: $(( (end - start)/1000000 )) ms"