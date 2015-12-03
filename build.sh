#!/bin/bash

# 03/12/2015 Written by Benjamin Richards (b.richards@qmul.ac.uk)
#
# Build script to build the WCSim package and dependancies from HyperK
#



#################### Build dependancies and WCSim #####################
cd build
if [ $1 = "dependancies" ]
then
git clone https://github.com/hyperk/hk-hyperk.git
cd hk-hyperk
echo '2'|./get_release.sh
source Source_At_Start.sh
./build.sh build
fi

#######################################################################

#################### Build just WCSim #################################

if [ $1 != "dependancies" ]
then
cd ./WCSim
#git checkout develop
source ../hk-hyperk/Source_At_Start.sh
make clean > "../hk-hyperk/log/wcsim-build.log" 2>&1
make rootcint > "../hk-hyperk/log/wcsim-build.log" 2>&1
make
fi

#######################################################################

cd ../../

