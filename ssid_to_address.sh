#!/bin/bash
#
# ssid -> address
#
# http://github.com/violentlydave
#
# ZGF2aWQgRE9UIGUgRE9UIHN3aXR6ZXIgYVQgICBHRWVlZU1BSUx6IERBV1QgQ09NCg==
#

# setup some stuffs.
IFS=$'\n'; DATE=`date +%Y%m%d_%H%M%S`; HERE=`pwd`
TODAY=`date +%Y-%m-%d`; DATE=`date`
CONFIGFILE="$HERE/breadcrumbs.conf"
BLAHBLAHBLAH=`egrep -e "^##BLAHBLAHBLAH" $CONFIGFILE | cut -d \= -f 2 | sed "s/\"//g"`
function log () { if [ ! -z $BLAHBLAHBLAH ]; then echo "$@"; fi }

SSID=$1
if [[ $# -eq 0 ]] ; then
	echo "$0 - script to go from SSID to a street address"; echo ""
	echo "Currently only works with local Wigle DB."; echo ""
	echo " usage:  $0 SSID"
	exit 1
fi

LOCATION=`echo "select lasttime,lastlat,lastlon from NETWORK where ssid like '$SSID';" | sqlite3 wiglewifi.sqlite`

if [ -z "$LOCATION" ]; then
	echo "Nothing found in the local db..."
	echo ""
	exit 1
fi

TIME=`echo $LOCATION | cut -d\| -f 1`; LAT=`echo $LOCATION | cut -d\| -f 2`; LON=`echo $LOCATION | cut -d\| -f 3`
if [ -z "$TIME" ]; then echo Not in the db..; exit 0; fi
ADDRESSINFO=`lynx -dump http://maps.googleapis.com/maps/api/geocode/json\?latlng=$LAT,$LON\&sensor=false | grep formatted | head -1 | cut -d \: -f 2 | sed "s/^\s//g" | sed "s/,$//g"`

echo SSID: $SSID , last seen: $TIME
echo Seen at: Latitude: $LAT / Longitude: $LON
echo Street address: $ADDRESSINFO
#echo Streetview: $STREETVIEW
#echo Map: $MAP
