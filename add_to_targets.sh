#!/bin/bash
# $1 = target name
# $2 = thing to search
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

OLDCONFIGFILE="$CONFIGFILE.$DATE"

#if [[ $# -eq 0 ]] ; then
if [[ -z "$1" ]]; then
	echo ""
        echo "$0 -- add targets to your list"
	echo "  -- searches current WUDS log for target info, adds to"
	echo " 	targets.conf"; echo ""; echo " usage:"
        echo " $0 TargetName thingtosearchfor"; echo "" 
    exit 1
fi

if [[ -z "$2" ]]; then echo "sigh more stuff here.."; exit 1; fi

for THINGIE in `./ssidscan.sh $2 | cut -d \| -f 2 | sort | uniq`; do echo "##target#$1#$THINGIE" >> newtargets.conf; done
egrep -e "^##target" $CONFIGFILE >> oldtargets.conf

# now cleanup the targets file
#mv targets.conf targets.new.conf
mv "$CONFIGFILE" "$OLDCONFIGFILE"
egrep -ve "^##target" "$OLDCONFIGFILE" >> $CONFIGFILE
egrep -ie "^##target" *targets.conf | tr '[:upper:]' '[:lower:]' | sed "s/newtargets\.conf\://g" | sed "s/oldtargets\.conf\://g" | sort | uniq  >> "$CONFIGFILE"

rm "$OLDCONFIGFILE"
rm newtargets.conf
rm oldtargets.conf
