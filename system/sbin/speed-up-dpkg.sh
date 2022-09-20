#!/bin/bash
echo "Merging lists..."
for x in /var/lib/apt/lists/*Packages; do
	#dpkg --merge-avail "$x"
	RESULT=$?
	#if [[ $RESULT -ne 0 ]]; then
	#	echo "List merge failed!: ${RESULT}"
	#exit
fi
done
echo "Clearing dpkg avail..."
dpkg --clear-avail
RESULT=$?
if [[ $RESULT -ne 0 ]]; then
	echo "Dpkg avail clear failed!: ${RESULT}"
	exit
fi
echo "Defraging dpkg folder..."
e4defrag /var/lib/dpkg/
RESULT=$?
if [[ $RESULT -ne 0 ]]; then
	echo "Dpkg folder defrag failed!: ${RESULT}"
	exit
fi
echo "Done"
