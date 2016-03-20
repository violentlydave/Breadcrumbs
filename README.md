## 
## Breadcrumbs: Wifi tracking/data leakage tools and toys
#

 Tools mentioned in "Breadcrumbs: Wifi Tracking/fun" talk 
 Slides: https://github.com/violentlydave/Breadcrumbs/blob/master/breadcrumbs1_postconf.pdf

Remember:
1> These tools are meant to automate some processes and show what's possible.
2> These tools should not be used for a "service" or considered secure code.
3> Email address is in the code

These tools are mostly used in conjunction with a modified version of WUDS,
available: https://github.com/violentlydave/WUDS-Breadcrumbs

Data requirements:
- "log.db" - output from WUDS (original or modified), can be anywhere if specified in config.
- "wiglewifi.sqlite" - sqlite3 DB straight from Wigle's phone app. Usually in "wiglewifi/" in your data area, often SDcard.

Files
- ssidscan.sh - tool to review the SQLITE3 db created by WUDS. No option shows all unique SSID probes in the log.  Any other text (as $1) will search for that showing up anywhere in the records.  You can add a second variable ($2) on the command line to specify a log-db other than "log.db" in case you roll your db regularly and want wish to search historical records.
- check_all_targets.sh - checks recent history in the logs, detects if any "targets" have been detected, and alerts.  It also creates a lock file w/ the date of first spotting so it doesn't constantly alert.
- detect_target.sh - The script that actually searches for the search string, called by check_all_targets.sh.
- clear_locks.sh - A quick script to clear the locks created by check_all_targets.sh -- usually add this into cron in early AM, or a different appropriate time for the cycle.
- add_to_targets.sh - searches the logs for the string listed, and adds all MAC addresses seen requesting that SSID.  It is a quick way to add a bunch of records, but be careful -- the targets config can become rather bloated if you don't notice your target is using MAC-spoofing.
- find_bluetoothaddr.sh - simple script to l2-ping up one MAC address and down one MAC address from the wifi interface, which will find most bluetooth addresses hosted on same SoC as wifi interface.
- ssid_to_address.sh - attempt to check the local DB for the SSID mentioned and map the lat/lon to a street address (GOOGLEMAPS version).
- ssid_to_name.sh - slightly modified "ssid to address", tries to reference local Florida voters DB.  Easily modifiable to other data sources, here as an example (GOOGLEMAPS version).
- latlon_to_address.sh - simlpe version of "ssid to address" to just take lat/lon found in other ways, show street address (GOOGLEMAPS version). 
- breadcrumbs.conf - Config file showing exempt strings, targets and alert-users (currently pushover only).

TODO:
- Rewrite most in python for flexibility (POC/quickie code = Bash. Sorry :( )
- Automate bluetooth sniffing portion after selecting target and figuringout
	bluetooth address.  Have it go as far as possible (ping/info collect)
	w/ regular hci interface, sniff on Ubertooth.
-
