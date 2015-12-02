#! /usr/bin/env sh

############################## Setting up git credentials ######################

git config --global credential.helper store 

git config --global user.email "b.richards@qmul.ac.uk.com"
git config --global user.name "brichards64"
git config --global push.default matching

#################################################################################

######### Creating firectory structure and downloading build tools ##############

echo `pwd`
cd ..

mkdir build

mv WCSim build/

git clone -b gh-pages --single-branch https://brichards64:$GITHUB_API_KEY@github.com/brichards64/WCSim.git tmp #> /dev/null 2>/dev/null

mv build tmp/

cd tmp

#################################################################################

################################## Trick to stop build timeout ##################
  
./buildextender.sh &
PID=$!
echo PID test $PID

#################################################################################

############################## Transfer cached reference output #################
 
mv /home/travis/reference ./

#################################################################################


########################### Start build and run ################################# 

mkdir output
./build.sh
./runsim.sh

./build/hk-hyperk/Source_At_Start.sh
./newmakewebpage.sh 

#################################################################################


################################### Push results to webpage #####################

git add -A
git reset -- build/*
git reset -- reference/*
git reset -- output/*

git commit -a -m $TRAVIS_COMMIT

git push > /dev/null 2>/dev/null

##https://brichards64:$GITHUB_API_KEY@github.com/brichards64/brichards64.github.io.git > /dev/null 2>/dev/null

#################################################################################

################################# Kill build timeout trick ######################

kill -9 $PID 

#################################################################################