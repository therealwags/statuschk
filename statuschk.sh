#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# statuschk.sh script - Display current status of pihole, fail2ban, updates
# © 2026 Wags
# Usage:
#         statuschk.sh [ -s | status ]
#         statuschk.sh [ -u | updates ]
#         statuschk.sh [ -h | help ]
#         statuschk.sh [ -v | version ]
# ---------------------------------------------------------------------------

### Constants ###
PROGNAME=${0##*/}
VERSION="1.5"

### Functions ###

## Help Related - Start ##
usage() {
  printf "%s\n" "Usage: ${PROGNAME} [ -suhv ]"
}

help_message() {
  cat <<- _EOF_
  Utility name: ${PROGNAME} 
  Current version: ${VERSION}

  Display current status of pihole, fail2ban, and updates

  $(usage)

  Options:
  -s  Display status of Fail3Ban and Pi-Hole
  -u  Display recent updates
  -h  Display this help message and exit.
  -v  Display current version of this utility.

_EOF_
}
## Help Related - End ##

## Menu Related - Start ##

menu() {
  clear
  PS3="Enter a number: "

  select func in status update help; do

    case $func in
      status)
        checkstatus ;;
      update)
        showupdates ;;
      help)
        help_message; exit 0 ;;
      *)
        printf "ERROR: Invalid option %s\n" "$REPLY" ;;
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
  printf "\n%s\n" "##################################################################"
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
  showUnattendedLog
  checkUpdates
}

set -euo pipefail
### debug
#set -x

### Clear screen ###
#clear

if [ "$#" -eq 0 ]; then
  menu
fi

while getopts ":hvsu" opt; do
  case $opt in
    h)
      help_message ;;
    v)
      printf "Version: %s\n" "$VERSION" ;;
    s)
      checkstatus ;;
    u)
      showupdates ;;
    \?)
      printf "ERROR: Invalid option -%s\n" "$OPTARG" 
      # echo "ERROR: Invalid option -$OPTARG"
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