#!/bin/bash
#
# http://github.com/violentlydave
#
# ZGF2aWQgRE9UIGUgRE9UIHN3aXR6ZXIgYVQgICBHRWVlZU1BSUx6IERBV1QgQ09NCg==


if [[ $# -eq 0 ]] ; then
        echo "$0 -- simple script to find an SSID in a WigleDB"
	echo "          ... mostly to save myself time ..."; echo ""
        echo " usage:"
        echo " $0 SSID [wigle db if not wiglewifi.sqlite]"
    exit 1
fi

if [ "$2" == "" ]; then LOGDB="./wiglewifi.sqlite"; fi 

SSID=$1
echo "select ssid,lastlat,lastlon,lasttime from NETWORK where ssid like '$SSID%';" | sqlite3 $LOGDB
