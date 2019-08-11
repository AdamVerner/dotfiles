#!/bin/sh

# or to /lib/systemd/system-sleep/

netioIp="192.168.20.50"
username="admin"
password="adminadmin"

case "$1" in
suspend|hibernate|pre)

	# try to pause spotify
	if pgrep -x "spotify" > /dev/null
	then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
	fi

	if pgrep -x "rhythmbox" > /dev/null
	then
		rhythmbox-client --pause
	fi

	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.1 i 0
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.4 i 0
	sleep 1
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.1 i 0
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.4 i 0
    ;;
resume|thaw|post)
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.1 i 1
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.4 i 1
	sleep 1
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.1 i 1
	snmpset -v 3 -a SHA -A $password -l authPriv -u $username -x AES -X $password $netioIp iso.3.6.1.4.1.47952.1.1.1.5.4 i 1
    ;;
esac

exit 0

