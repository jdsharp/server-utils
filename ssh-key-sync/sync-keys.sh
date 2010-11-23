#!/bin/sh
HOSTS=`cat hosts.txt`
SCRIPT="#!/bin/sh
INLINEKEYS=\"`cat keys.txt`\"
`cat add-keys.sh`"

for host in $HOSTS;
do
    echo "local: Connecting to $host...";
	ssh $host "$SCRIPT"
	echo "local: done.";
	echo "";
done

