## 
## Breadcrumbs: Wifi tracking/data leakage tools and toys
#
# Tools from "Wifi Tracking" talk at BSides Orlando 2016

** THIS WILL CHANGE ALOT WORKING UP TO MARCH 12/13th !

These tools are mostly used in conjunction with a modified version of WUDS,
available: https://github.com/violentlydave/WUDS-Breadcrumbs

Files
- ssidscan.sh - tool to review the SQLITE3 db created by WUDS. No option shows all unique SSID probes in the log.  Any other text (as $1) will search for that showing up anywhere in the records.  You can add a second variable ($2) on the command line to specify a log-db other than "log.db" in case you roll your db regularly and want wish to search historical records.
- check_all_targets.sh - checks recent history in the logs, detects if any "targets" have been detected, and alerts.  It also creates a lock file w/ the date of first spotting so it doesn't constantly alert.
- detect_target.sh - The script that actually searches for the search string, called by check_all_targets.sh.
- clear_locks.sh - A quick script to clear the locks created by check_all_targets.sh -- usually add this into cron in early AM, or a different appropriate time for the cycle.
- add_to_targets.sh - searches the logs for the string listed, and adds all MAC addresses seen requesting that SSID.  It is a quick way to add a bunch of records, but be careful -- the targets config can become rather bloated if you don't notice your target is using MAC-spoofing.
- targets.conf
- wirelesstools.con
 


