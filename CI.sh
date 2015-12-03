#! /usr/bin/env sh

############################## Setting up git credentials #######################

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

if [ $1 = "normal" ]
then
mv /home/travis/reference ./
fi

if [ $1 != "dependancies" ]
then
mv /home/travis/hk-hyperk ./build/
mv /home/travis/hk-config ./build/
mv /home/travis/CLHEP ./build/
mv /home/travis/Geant4 ./build/
mv /home/travis/root ./build/
fi

#################################################################################


########################### Start build and run ################################# 

if [ $1 != "normal" ]
then
mkdir reference
fi

mkdir output

./build.sh $1
./runsim.sh

if [ $1 != "normal" ]
then
cp output/* reference/
fi

./build/hk-hyperk/Source_At_Start.sh
./newmakewebpage.sh 
exitstatus=$?

#################################################################################


################################### Push results to webpage #####################

git add -A
git reset -- build/*
git reset -- reference/*
git reset -- output/*

git commit -a -m $TRAVIS_COMMIT

git push > /dev/null 2>/dev/null

#https://brichards64:$GITHUB_API_KEY@github.com/brichards64/brichards64.github.io.git > /dev/null 2>/dev/null

#################################################################################


if [ $1 != "normal" ]
then
cp output/* reference/
fi

mv ./reference  /home/travis/
mv ./build/hk-hyperk /home/travis/
mv ./build/hk-config /home/travis/
mv ./build/CLHEP /home/travis/
mv ./build/Geant4 /home/travis/
mv ./build/root /home/travis/





################################# Kill build timeout trick ######################

kill -9 $PID 

################################################################################

exit $exitstatus