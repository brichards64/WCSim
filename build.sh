#!/bin/bash

# 03/12/2015 Written by Benjamin Richards (b.richards@qmul.ac.uk)
#
# Build script to build the WCSim package and dependancies from HyperK
#



#################### Build dependancies and WCSim #####################
cd build
if [ $1 = "dependancies" ]
then
    git clone https://github.com/hyperk/CLHEP.git CLHEP
    cd CLHEP/
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX= ../source/2.2.0.4/CLHEP  > ../../../clhep-build.log 2>&1
    make >> ../../../clhep-build.log 2>&1
    make install >> ../../../clhep-build.log 2>&1
    echo location 1
    echo `pwd`
    
    cd ../..
    git clone https://github.com/hyperk/Geant4.git Geant4
    cd Geant4
    mkdir build
    cd build
#    cmake -DGEANT4_INSTALL_DATA=ON -DGEANT4_INSTALL_DATADIR=./Data -DCMAKE_INSTALL_PREFIX=./install -DCLHEP_VERSION_OK=${CLHEP_VERSION} -DCLHEP_LIBRARIES= ./lib -DCLHEP_INCLUDE_DIRS= ./include ../source/4.10.01.p02/ > ../../../geant4-build.log 2>&1
 #   make >> ../../../geant4-build.log 2>&1
  #  make install >> ../../../geant4-build.log 2>&1
    echo location 2
    echo `pwd`
    
    cd ../..
    git clone http://root.cern.ch/git/root.git root
    cd root
    cat ./configure | sed s:'enable_cxx11=yes':'enable_cxx11=no': >configurex
    mv configurex configure
    ./configure --disable-cxx11  --enable-python --enable-roofit --enable-minuit2 > ../../root-build.log 2>&1
    make >> ../../root-build.log 2>&1
    source bin/thisroot.sh
    echo location 3
    echo `pwd`
    
    cd ../WCSim
    make clean
    make rootcint > ../../wcsim-build.log 2>&1
    make > ../../wcsim-build.log 2>&1

>>>>>>> b38db18b9e17c3fbab90a9a2a275b19fa1463b2c
    
#git clone https://github.com/hyperk/hk-hyperk.git
#cd hk-hyperk
#echo '2'|./get_release.sh
#source Source_At_Start.sh
#./build.sh build
fi

#######################################################################

#################### Build just WCSim #################################

if [ $1 != "dependancies" ]
then
cd ./WCSim
#git checkout develop
source ../hk-hyperk/Source_At_Start.sh
make clean > "../hk-hyperk/log/wcsim-build.log" 2>&1
make rootcint >> "../hk-hyperk/log/wcsim-build.log" 2>&1
make
fi

#######################################################################

cd ../../

