#!/bin/bash

################## index.html head  #######################

echo "<head>
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />
<title>WCSim Validation</title>
</head>

<body>
<h1 align=\"center\">WCSim Validation</h1>

<table width=\"800\" border=\"2\" align=\"center\">
<legend>Validation history</legend>
<td>

" > index.html

i=0
pend=$(wc -l log.txt | cut -f1 -d' ')
pstart=$(expr $pend - 20)

while read line 
do
    if [ $i -gt $pstart ] && [ $i -lt $pend ]
    then
	echo $line "<br>" >>index.html
    fi
    
i=$(expr 1 + $i)

done< log.txt 


echo "
xxxxlogmessagexxxx <br>

</td>
</table>
<p>
<table width='800' border='1' align='center'>
" >> index.html
#<tr>
#<th scope='col'><div align='center'>Job Id </div></th>
#<th scope='col'><div align='center'>Description</div></th>
#<th scope='col'><div align'center'>Status</div></th>
#</tr>
#" >> index.html


####################################################




################## Status logic  #######################

log="SUCCESSFUL"

while read line
do
    
    if [ ${line::1} != "#" ] 
    then
	
	name=$(echo $line | cut -f1 -d' ')
	test=$(echo $line | cut -f2 -d' ')
	var1=$(echo $line | cut -f3 -d' ')
	var2=$(echo $line | cut -f4 -d' ')
	var3=$(echo $line | cut -f5 -d' ')
	var4=$(echo $line | cut -f6 -d' ')
	
################## Build Test #######################

	if [ $test == "BuildTest"  ] 
	then
	    if [ ! -e $var1$var2 ]
	    then
		pass=#FF0000
		log=$name" FAIL "
	    else
		pass=#00FF00
	    fi

	    cp  $var3/$var4 ./$var4

	    echo "
	    <tr>
	    <td bgcolor=\""$pass"\"><a href='"$var4"'>"$name"</td>
	    <td bgcolor=\""$pass"\">Build test</td> 
	    <td bgcolor=\""$pass"\">" `if [ $pass == "#00FF00" ] ; then  echo 'PASS';  else echo 'FAIL';  fi`"</td>
	    </tr>
">>index.html	    
	    
	fi
####################################################

################## File Test #######################

	if [ $test == "FileTest" ]
	then
	    if [ ! -e $var1 ]
	    then	
		pass=#FF0000
		log=$name" FAIL "
	    else
		pass=#00FF00
	    fi
 echo "
	    <tr>
	    <td bgcolor=\""$pass"\">"$name"</td>
	    <td bgcolor=\""$pass"\">File Created</td> 
	    <td bgcolor=\""$pass"\">" `if [ $pass == "#00FF00" ] ; then  echo 'PASS';  else echo 'FAIL';  fi`"</td>
	    </tr>
">>index.html
	   
	fi

#####################################################   
################## Physics validation ###############

	if [ $test == "PhysicsValidation" ]
	then
	   #echo $var1
	   #echo $var2
	   #echo $var3
	    rm -rf $var1
	    mkdir $var1
	    
	    cd ./compout
	    source ../build/hk-hyperk/Source_At_Start.sh
	    ./compareroot ../$var1 $var2 $var3 
	    if [ $? -ne 0 ]
	    then
		pass=#FF0000
		log=$name" VALIDATION FAIL "
	    else
		pass=#00FF00
	    fi

	cd ../



 echo "
	    <tr>
	    <td bgcolor=\""$pass"\"><a href='"`echo $var1 | cut -f1 -d'.'`"/index.html'>"$name"</td>
	    <td bgcolor=\""$pass"\">Physics Validation</td> 
	    <td bgcolor=\""$pass"\">" `if [ $pass == "#00FF00" ] ; then  echo 'PASS';  else echo 'FAIL';  fi`"</td>
	    </tr>
">>index.html

	fi
	
####################################################  
################## Blank line  ###############

	if [ $test == "Blank" ]
	then

	  
 echo "
	    <tr>
            <th colspan=\"3\"><span>&#8203;</span></th>
	    </tr>
">>index.html

	fi
	
####################################################

################## Title line  ###############

	if [ $name == "Title" ]
	then

	    text=$(echo $line | sed s:$name:: )
	  
 echo "
	    <tr>
            <th colspan=\"3\">"$text"</th>
	    </tr>
            <tr>
            <th scope='col'><div align='center'>Job Id </div></th>
            <th scope='col'><div align='center'>Description</div></th>
            <th scope='col'><div align'center'>Status</div></th>
            </tr>

">>index.html

	fi
	
####################################################

    fi

    done<tests.txt


####################################################

################# finish off webpage  #######

echo "

</table>
<h1 align='center'>&nbsp; </h1>
</body>
</html>
" >> index.html

tail -n 20 log.txt | cat log.txt
echo  `date` " : "$log  >>log.txt  

message=`date`" [commit="$TRAVIS_COMMIT"]: "$log

echo `more index.html | sed s/xxxxlogmessagexxxx/"$message"/`  >index.html




####################################################


################# Email me if not successful #######

if [ "$log" != "SUCCESSFUL" ]
then
exit 1
#echo $log | mail -s “WCSim\ VALIDATION\ ERROR!!!!” b.richards@qmul.ac.uk
fi

####################################################
