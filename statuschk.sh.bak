#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# statuschk.sh script - Display status of pihole, fail2ban, and updates
# © 2026 Wags
# Usage:
#         statuschk.sh [ -s | status ]
#         statuschk.sh [ -u | updates ]
#         statuschk.sh [ -m | memory info ]
#         statuschk.sh [ -h | help ]
#         statuschk.sh [ -v | version ]
#
# Notes:
#         v1.7: reformat README using markdown
#         v1.6: added option m to display memory information (free)
#         v1.5: added menu and getops options u (updates) & s (status)
#         v1.0: added getops options h (help) & v (version)
#         v0.5: initial script design that always ran everything
# ---------------------------------------------------------------------------
# TODO: modularize the script
# ---------------------------------------------------------------------------

set -euo pipefail
### debug

#set -x

### Constants ###
PROGNAME=${0##*/}
VERSION="1.7"

### Functions ###

## Help Related - Start ##
usage() {
  printf "%s\n" "Usage: ${PROGNAME} [ -sumhv ]"
}

help_message() {
  cat <<- _EOF_
  Utility name: ${PROGNAME} 
  Current version: ${VERSION}

  Display current status of pihole, fail2ban, and updates

  $(usage)

  Options:
  -s  Display status of services: fail2ban and Pi-Hole
  -u  Display available updates and recent upgrades.
  -m  Display memory information.
  -h  Display this help message and exit.
  -v  Display current version of this utility.

_EOF_
}
## Help Related - End ##

## Menu Related - Start ##

menu() {
  clear
  PS3="Enter a number: "

  select func in status update help quit; do

    case $func in
      status)
        checkstatus; exit 0 ;;
      update)
        showupdates; exit 0 ;;
      help)
        help_message; exit 0 ;;
      quit)
        printf "Good-bye!"; exit 0 ;;
      *)
        printf "ERROR: Invalid option %s\n" "$REPLY"; exit 1 ;;
    esac
  
  done
}
## Menu Related - End ##

## Service Status Related - Start ##

# Display current Pi-Hole status
getPiholeStatus() {
  printf "Current Pi-Hole Status:\n\n"
  sudo pihole status verbose
}

# Display current fail2ban status
getFail2banStatus() {
  printf "Current Fail2Ban Client Status:\n\n"
  sudo fail2ban-client status sshd
}

# Display free and used memory in the system
getMemoryStatus() {
  printf "Current free and used memory:\n\n"
  free -hlw
}

## Service Status Related - End ##

## Updated Related - Start ##

# Check if updates are needed
checkUpdates() {
  printf "Checking for updates:\n\n"
  sudo apt update
}

# Display Unattended Upgrade log
showUnattendedLog() {
  printf "Latest unattended upgrade entries:\n\n"
  sudo tail -n 25 /var/log/unattended-upgrades/unattended-upgrades-dpkg.log
}

## Updated Related - End ##

makePretty() {
  printf "\n%s\n\n" "****************************************************************************************"
}

checkstatus() {
  clear
  makePretty
  getFail2banStatus
  makePretty
  getPiholeStatus
  makePretty
  getMemoryStatus
  makePretty
}

showupdates() {
  clear
  makePretty
  showUnattendedLog
  makePretty
  checkUpdates
  makePretty
}

# If no options detected, show menu
if [ "$#" -eq 0 ]; then
  menu
fi

# Provide options
while getopts ":hvsum" opt; do
  case $opt in
    h)
      help_message ;;
    v)
      printf "Version: %s\n" "$VERSION" ;;
    s)
      checkstatus ;;
    u)
      showupdates ;;
    m)
      getMemoryStatus ;;
    \?)
      printf "ERROR: Invalid option -%s\n" "$OPTARG" 
      help_message
      exit 1
      ;;
    # :)
    #   echo "ERROR: Option -$OPTARG requires an argument."
    #   usage
    #   exit 1
    #   ;;
  esac
done