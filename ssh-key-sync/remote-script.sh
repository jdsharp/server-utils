SSHDIR="$HOME/.ssh"
AUTHKEYS="$SSHDIR/authorized_keys"
SSHKEYS="$HOME/.ssh/keys.txt"

echo "Connected to "`hostname`" as $USER";

if [ ! -d "$SSHDIR" ]; then
    echo "Creating $SSHDIR";
    mkdir "$SSHDIR"
fi

if [ ! -d "$SSHDIR" ]; then
    echo "Failed to create $SSHDIR";
    exit;
fi

if [ "$INLINEKEYS" = "" ]; then
	echo "INLINEKEYS is empty, no SSH keys to add, exiting.";
	exit;
fi

echo "Creating $SSHKEYS file";
echo "$INLINEKEYS" > $SSHKEYS;

i=1
while [ $i -le `wc -l "$SSHKEYS" | gawk '{print $1}'` ] ; do
    line=`head -$i "$SSHKEYS" | tail -1`
    key=`echo "$line"|awk '{print $2}'`
    owner=`echo "$line"|awk '{print $3}'`
    if [ `grep "$key" $AUTHKEYS|wc -l` -gt 0 ]; then
        echo "Key exists for $owner";
    else
        echo "Adding key for $owner";
        echo "$line" >> $AUTHKEYS;
    fi
    i=`expr $i + 1`
done

echo "Removing $SSHKEYS file";
rm -v $SSHKEYS;
