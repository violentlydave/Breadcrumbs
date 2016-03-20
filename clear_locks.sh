#!/bin/bash
# clear_locks.sh - clear the "breadcrumb" target locks
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

LOCKS=`grep -e "^##LOCKS" $CONFIGFILE | cut -d \= -f 2`

for A in `ls $LOCKS/*lock`; do rm echo "$A"; done
