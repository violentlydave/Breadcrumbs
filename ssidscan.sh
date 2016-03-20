#!/bin/bash
# ssidscan.sh - script to go through sqlite DB from WUDS
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

LOGDB=$2
if [ "$2" == "" ]; then LOGDB="./log.db"; fi 
EXEMPT=`egrep -e "^##EXEMPT" breadcrumbs.conf | cut -d \= -f 2`
#echo exempt: $EXEMPT
if [ "$1" == "" ]; then
        echo "select * from probes;" | sqlite3 $LOGDB | cut -d \| -f 4 | sort | uniq | egrep -ve "$EXEMPT"
else
        echo "select * from probes;" | sqlite3 $LOGDB  | egrep -i -e $1 | egrep -ve "$EXEMPT"
fi
