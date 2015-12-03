#!/bin/bash

# 02/12/2015 Written by Benjamin Richards (b.richards@qmul.ac.uk)
#
# Run script to produce output for further physics testing
#


cd build

source hk-hyperk/Source_At_Start.sh

cd WCSim/


################### copy .mac files and usefule helper files ##############

cp -r ../../compout/rootwc ./
cp ../../compout/wcsim_*.mac ./

###########################################################################

########################## Create test output  ############################


./exe/bin/Linux-g++/WCSim novis.mac

./exe/bin/Linux-g++/WCSim wcsim_10e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.mac

./exe/bin/Linux-g++/WCSim wcsim_100e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.mac

./exe/bin/Linux-g++/WCSim wcsim_500e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.mac

./exe/bin/Linux-g++/WCSim wcsim_200mu-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.mac

./exe/bin/Linux-g++/WCSim wcsim_800mu-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.mac

############################################################################


############################ Build root readable output program ############

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`


cd sample-root-scripts/

cp ../../../compout/daq_readfilemain.C ./

g++ daq_readfilemain.C -o daq_readfilemain -I ../include/ -L ../ -lWCSimRoot `root-config --libs --cflags`

############################################################################

######################### Generate root readable output trees ##############

./daq_readfilemain wcsim_10e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root

./daq_readfilemain wcsim_100e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root

./daq_readfilemain wcsim_500e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root

./daq_readfilemain wcsim_200mu-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root

./daq_readfilemain wcsim_800mu-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root

############################################################################

########################## Create links in output folder ###################

ln -s `pwd`/analysed_wcsim_10e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root ../../../output/

ln -s `pwd`/analysed_wcsim_100e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root ../../../output/

ln -s `pwd`/analysed_wcsim_500e-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root ../../../output/

ln -s `pwd`/analysed_wcsim_200mu-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root ../../../output/

ln -s `pwd`/analysed_wcsim_800mu-_SuperK_Stacking_Only_PMTCollEff_on_SKI_digi0_200_NDigits_fails0_NDigits25_200_DarkNoiseM1C1.367R4.2W1500.root ../../../output/

############################################################################


cd ../../../

