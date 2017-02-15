#!/bin/bash

# 03/12/2015 Written by Benjamin Richards (b.richards@qmul.ac.uk)
#
# Build script to build the WCSim package and dependancies from HyperK
#



#################### Build dependancies and WCSim #####################
cd build
if [ $1 = "dependancies" ]
then
    echo STARTING CLHEP BUILD `pwd`
    git clone https://github.com/hyperk/CLHEP.git CLHEP
    cd CLHEP/
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX= ../source/2.2.0.4/CLHEP  > ../../../clhep-build.log 2>&1
    make -j8 >> ../../../clhep-build.log 2>&1
    make install >> ../../../clhep-build.log 2>&1
    echo location 1
    echo `pwd`

    echo STARTING GEANT4 BUILD `pwd`
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

    echo STARTING CMAKE BUILD `pwd`
    cd ../..
    wget https://cmake.org/files/v3.8/cmake-3.8.0-rc1-Linux-x86_64.tar.gz --no-check-certificate
    tar zxf cmake-3.8.0-rc1-Linux-x86_64.tar.gz
    cd cmake-3.8.0-rc1-Linux-x86_64/bin
    export PATH=`pwd`:$PATH
  

    echo STARTING ROOT BUILD `pwd`
    cd ../..
    git clone http://root.cern.ch/git/root.git root
    cd root
    mkdir build
    cd build
    #cat ./configure | sed s:'enable_cxx11=yes':'enable_cxx11=no': > configurex
    #mv configurex configure
    #chmod a+x configure
    echo starting configure
#    ./configure  --enable-python --enable-roofit --enable-minuit2 > ../../root-build.log 2>&1
    cmake -DCMAKE_INSTALL_PREFIX= ../ > ../../../root-build.log 2>&1
    echo starting make 
    make -j8 >> ../../root-build.log 2>&1
    make install >> ../../root-build.log 2>&1
    #>> ../../root-build.log 2>&1
    echo location 3
    echo `pwd`

    echo STARTING WCSIM BUILD `pwd`
    cd ../../WCSim
  # make clean
  #  make rootcint -j8 > ../../wcsim-build.log 2>&1
  #  make -j8 > ../../wcsim-build.log 2>&1

    
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
make rootcint -j8 >> "../hk-hyperk/log/wcsim-build.log" 2>&1
make -j8
fi

#######################################################################

cd ../../

