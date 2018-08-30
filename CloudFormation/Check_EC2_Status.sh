#!/bin/bash

if [ $# -ne 1]
then
	echo "Please provide the Parameters: Machine IP"
	exit 2
fi

SERVERIP=$1
NOTIFYEMAIL=test@example.com

ping -c 3 $SERVERIP > /dev/null 2>&1
if [ $? -ne 0 ]
then
   # Use your favorite mailer here:
   mailx -s "Server $SERVERIP is down" -t "$NOTIFYEMAIL" < /dev/null 
fi