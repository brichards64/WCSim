# Webpage and Tools

****************************
#Description
****************************

This branch holds the webpage information for the build tests which can be viewed at www.brichards64.github.io/WCSim and all the tools needed to build the webpage.

The TravisCI script with run the following scripts in order:

1) build.sh : This build both WCSim and its dependancies

2) run.sh : This executes WCSim and generates output files and creates TTRees with usefull output variables in the output directory

3) newmakewebpage.sh : This generates the webpage output baised on the tests.txt configuration file. It also executes the compareroot program on the output of run.sh to compare with reference output.  


*******************************
#Changing configuration
*******************************

Tests can be added or changed by editing the tests.txt file (instructions found within ) if extra output files are needed they can be generated in the run.sh script.


*******************************

created by Benjamin Richards (b.richards@qmul.ac.uk)
























 03/12/2015 Written by Benjamin Richards (b.richards@qmul.ac.uk)

 


