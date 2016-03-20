#!/bin/bash
# latlon-> address
# 
# http://github.com/violentlydave
#
# ZGF2aWQgRE9UIGUgRE9UIHN3aXR6ZXIgYVQgICBHRWVlZU1BSUx6IERBV1QgQ09NCg==
#
#

# setup some stuffs.
IFS=$'\n'; DATE=`date +%Y%m%d_%H%M%S`; HERE=`pwd`
TODAY=`date +%Y-%m-%d`; DATE=`date`
CONFIGFILE="$HERE/breadcrumbs.conf"
BLAHBLAHBLAH=`egrep -e "^##BLAHBLAHBLAH" $CONFIGFILE | cut -d \= -f 2 | sed "s/\"//g"`
function log () { if [ ! -z $BLAHBLAHBLAH ]; then echo "$@"; fi }

if [ -z "$2" ]; then
	echo " $0 - converts lat/lon to a street address"; echo ""
	echo "Please enter lat and lon as the first and second commandline argument."; echo ""
	echo " ex:  $0 27.9581467318 -82.4597656453"; echo ""
	exit 1
fi

LAT=$1; LON=$2

ADDRESSINFO=`lynx -dump http://maps.googleapis.com/maps/api/geocode/json\?latlng=$LAT,$LON\&sensor=false | grep formatted | head -1 | cut -d \: -f 2 | sed "s/^\s//g" | sed "s/,$//g"`

echo Seen at: Latitude: $LAT / Longitude: $LON
echo Street address: $ADDRESSINFO
