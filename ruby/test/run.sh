#!/bin/bash

BASEDIR="$(dirname "$0")"
CURRENTDIR=`pwd`

# a function to check the execution status
function test {
	"$@" 1>/dev/null
	status=$?
	if [ $status -ne 0 ]; then
		echo "$2 [Failed]"
	else
		echo "$2 [OK]"
	fi
	return $status
}

# go to test's base dir
cd $BASEDIR

##
# Tests use deterministic problem
##
testcases[0]="test1.sfp"
testcases[1]="test2.sfp"
testcases[2]="test3.sfp"
testcases[3]="test4.sfp"
testcases[4]="test5.sfp"
testcases[5]="test6.sfp"
testcases[6]="test7.sfp"

echo "Deterministic usecases..."
for tc in "${testcases[@]}"
do
	test ../bin/sfp $tc
done

##
# Tests use non-deterministic problems
##
testcases[0]="nd-service1.sfp"
testcases[1]="nd-service2.sfp"
testcases[2]="nd-cloud1.sfp"
testcases[3]="nd-cloud2.sfp"
testcases[4]="nd-cloud3.sfp"

echo "Non-Deterministic usecases..."
for tc in "${testcases[@]}"
do
	test ../bin/sfp $tc
done

##
# Back to previous directory
##
cd $CURRENTDIR
