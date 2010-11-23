#!/bin/sh
HOSTS=`cat hosts.txt`
REMOTESCRIPT="#!/bin/sh
INLINEKEYS=\"`cat keys.txt`\"
`cat remote-script.sh`"

for host in $HOSTS;
do
    echo "local: Connecting to $host...";
	ssh $host "$REMOTESCRIPT"
	echo "local: done.";
	echo "";
done

