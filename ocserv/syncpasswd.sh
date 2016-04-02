#!/bin/bash
URL='https://ssworld.ga/anyconnect.php?key=P3IA6OXBzqPOFfO7MH9NbwwiWtF530VdS8JiJ8HL1Yohhyb2NcO6vmCMfJgW'
wget -O /etc/ocserv/passwd.new $URL > /dev/null
if [ $? -ne 0 ]; then
	echo "Failed"
else
	echo "Succeeded"
	mv /etc/ocserv/passwd.new /etc/ocserv/passwd
fi

