#!/bin/bash
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

TARGETSCONF=`grep TARGETSCONF $CONFIGFILE | cut -d \= -f 2`
for TARGET in `egrep -i '^##target' $TARGETSCONF`; do 
	TARGETNAME=`echo $TARGET | cut -d\# -f 4`
	TARGETSEARCH=`echo $TARGET | cut -d\# -f 5`
#echo my target name $TARGETNAME
#echo my target search $TARGETSEARCH
	/usr/local/src/wuds/detect_target.sh $TARGETNAME $TARGETSEARCH
	sleep 1
done



