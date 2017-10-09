#!/bin/bash
URL=`cat /dogespeed/api.txt`
wget -O /etc/ocserv/passwd.new $URL > /dev/null
if [ $? -ne 0 ]; then
	echo "Failed"
else
	echo "Succeeded"
	mv /etc/ocserv/passwd.new /etc/ocserv/passwd
fi
