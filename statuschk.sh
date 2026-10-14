#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# status-check.sh script - Display current status of pihole, fail2ban, updates
# © 2026 Wags
# Usage: status-check.sh [ -h | help ]
# ---------------------------------------------------------------------------

### Constants ###
PROGNAME=${0##*/}
VERSION="0.5"

### Functions ###

# Display current Pi-Hole status
getPiholeStatus () {
  printf "Current Pi-Hole Status:\n\n"
  sudo pihole status verbose
}

# Display current fail2ban status
getFail2banStatus () {
  printf "Current Fail2Ban Client Status:\n\n"
  sudo fail2ban-client status sshd
}

# Display free and used memory in the system
getMemoryStatus () {
  printf "Current free and used memory:\n\n"
  free -hlw
}

# Check if updates are needed
checkUpdates () {
  printf "Checking for updates:\n\n"
  sudo apt update
}

# Display Unattended Upgrade log
showUnattendedLog () {
  printf "Latest unattended upgrade entries:\n\n"
  sudo tail -n 25 /var/log/unattended-upgrades/unattended-upgrades-dpkg.log
}

makePretty (){
  printf "\n%s\n" "##################################################################"
}

usage() {
  printf "%s\n" "Usage: ${PROGNAME} [ -hv ]"
}

help_message(){
  cat <<- _EOF_
  Utility name: ${PROGNAME} 
  Current version: ${VERSION}

  Display current status of pihole, fail2ban, updates

  $(usage)

  Options:
  -h  Display this help message and exit.
  -v  Display current version of this utility.

_EOF_
}

set -euo pipefail
### debug
#set -x

while getopts ":hv" opt; do
  case $opt in
    h)
      help_message
      exit 0
      ;;
    v)
      printf "Version: %s\n" $VERSION
      # echo $VERSION
      exit 0
      ;;
    \?)
      echo "ERROR: Invalid option -$OPTARG" 
      usage
      exit 1
      ;;
    # :)
    #   echo "ERROR: Option -$OPTARG requires an argument."
    #   usage
    #   exit 1
    #   ;;
  esac
done

### Clear screen ###
clear

### Run functions ###

makePretty
getPiholeStatus
makePretty
sleep 3s
getFail2banStatus
makePretty
sleep 3s
getMemoryStatus
makePretty
checkUpdates
makePretty
showUnattendedLog
makePretty