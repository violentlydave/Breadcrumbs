#!/bin/bash
#
# http://github.com/violentlydave
# ZGF2aWQgRE9UIGUgRE9UIHN3aXR6ZXIgYVQgICBHRWVlZU1BSUx6IERBV1QgQ09NCg==
#

# setup some stuffs.
IFS=$'\n'; DATE=`date +%Y%m%d_%H%M%S`; HERE=`pwd`
TODAY=`date +%Y-%m-%d`; DATE=`date`
CONFIGFILE="$HERE/breadcrumbs.conf"
BLAHBLAHBLAH=`egrep -e "^##BLAHBLAHBLAH" $CONFIGFILE | cut -d \= -f 2 | sed "s/\"//g"`
function log () { if [ ! -z $BLAHBLAHBLAH ]; then echo "$@"; fi }

if [ -z "$2" ]; then
        echo "$0 -- simple script to alert if user is around"
        echo "" 
        echo " usage:"
	echo " $0 target_name thing_to_search_for"
    exit 1
fi

# setup some variables
TODAY=`date +%Y-%m-%d`; DATE=`date`
TARGET=`echo $1 | tr '[:upper:]' '[:lower:]'`
SEARCH=`echo $2 | tr '[:upper:]' '[:lower:]'`
LOCKS=`grep -e "^##LOCKS" $CONFIGFILE | cut -d \= -f 2`; mkdir -p $LOCKS; LOCK="$LOCKS/$TARGET.lock"
HOST=`hostname`
#echo my lock : $LOCK / host: $HOST / target $TARGET / search $SEARCH / date $DATE / today $TODAY

# check if lock exists/has a date, if so exit
if [[ -s $LOCK ]] ; then echo fuck i have a lock $LOCK; exit 0; fi

# nope, so check for user
STATUS=`$HERE/ssidscan.sh $TODAY | grep -i $SEARCH | head -1`
if [[ -z "$STATUS" ]]; then exit 0; fi

# he/she/it is here, so let's mark it + alert
echo $DATE > $LOCK

MESS="$TARGET detected on $HOST at $DATE."
MESSAGE=`echo $MESS | sed "s/\ /_/g"`

# sweet let's let the peeps know.
for ALERTUSER in `egrep -i '^##alertuser' $CONFIGFILE`; do 
	TOKEN=`echo $ALERTUSER | cut -d \: -f 3`
	USERTOKEN=`echo $ALERTUSER | cut -d \: -f 4`

	curl -s -F "token=$TOKEN" -F "user=$USERTOKEN" -F "title=fire" \
	    -F "message=$MESSAGE" https://api.pushover.net/1/messages.json
done
