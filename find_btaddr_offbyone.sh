#!/bin/bash
#
# http://github.com/violentlydave
# ZGF2aWQgRE9UIGUgRE9UIHN3aXR6ZXIgYVQgICBHRWVlZU1BSUx6IERBV1QgQ09NCg==
#
# l2ping -c 1 60:1E:D2:FF:AE:1A; echo $?
# take last octet, add one (hex), try pinging
#     if ping works, that = bluetooth

# setup some stuffs.
IFS=$'\n'; DATE=`date +%Y%m%d_%H%M%S`; HERE=`pwd`
TODAY=`date +%Y-%m-%d`; DATE=`date`
CONFIGFILE="$HERE/breadcrumbs.conf"
BLAHBLAHBLAH=`egrep -e "^##BLAHBLAHBLAH" $CONFIGFILE | cut -d \= -f 2 | sed "s/\"//g"`
function log () { if [ ! -z $BLAHBLAHBLAH ]; then echo "$@"; fi }

if [[ $# -eq 0 ]] ; then
	echo ""; echo " $0 - script to find bluetooth MAC addy via off-by-one"
	echo ""; echo " usage:"
        echo  " $0 WIFIMACADDRESS [optional HCI dev name, ex: hci1]"
	echo  "              (WIFIMACADDRESS should be in the format of AA:BB:CC:DD:EE:FF)"; echo ""
    exit 1
fi

# Define our bloo-toofs.
HCIDEV=$2; if [ "$2" == "" ]; then HCIDEV="hci0"; fi
# did ya know BC hates HEX w/ lowercase?.. yeah I didn't either.. dfsasdjflasjkdf
WIFIMAC=`echo $1 | tr '[:lower:]' '[:upper:]'`

if [[ ${#WIFIMAC} -lt 17 ]]; then echo "Hrm.. that MAC smells funny.  Is it in the AA:BB:CC:DD:EE:FF format?"; exit 1; fi

# because math.  sloppy, sloppy math.
FIRSTFIVE=`echo $WIFIMAC | cut -d \: -f 1,2,3,4,5`
LAST=`echo $WIFIMAC | cut -d \: -f 6`; LASTDEC=`echo "ibase=16; $LAST" | bc`
DECPLUSONE=`expr $LASTDEC + 1`; DECMINUSONE=`expr $LASTDEC - 1`
HEXPLUSONE=`echo "obase=16; $DECPLUSONE" | bc`; HEXMINUSONE=`echo "obase=16; $DECMINUSONE" | bc`
TRIALMAC=$FIRSTFIVE":"$HEXPLUSONE

# need to find a better check.. faster and doesn't spew info.. hcitool f's up the exit code
until l2ping -c 2 $TRIALMAC > /dev/null 2>&1 ; do
	if [[ "$TRIALMAC" = $FIRSTFIVE\:$HEXMINUSONE ]]; then exit 1; fi
	TRIALMAC=$FIRSTFIVE":"$HEXMINUSONE
done

log "CORRECT MAC FOR BLUETOOTH IS : $TRIALMAC"
log "---------------------------"
    if [ ! -z $VERBOSE ]; then
	hcitool info $TRIALMAC
    fi

echo $TRIALMAC
