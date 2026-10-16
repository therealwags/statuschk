#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# statuschk.sh - Display current status of the Pi-Hole and fail2ban services,
#                 any pending updates, and recent unattended upgrades
# © 2026 Wags
#
# Usage:
#         statuschk.sh [ -s | services ]
#         statuschk.sh [ -u | updates ]
#         statuschk.sh [ -m | memory info ]
#         statuschk.sh [ -h | help ]
#         statuschk.sh [ -v | version ]
#
# Notes:
#         v2.0: split into modules
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
VERSION="2.0"

### Source modules ###
source ./memory.sh
source ./updates.sh
source ./services.sh
source ./menu.sh

## Help Related - Start ##
usage() {
  printf "%s\n" "Usage: ${PROGNAME} [ -sumhv ]"
}

help_message() {
  cat <<- _EOF_
  Nname: ${PROGNAME} 
  Version: ${VERSION}

  Display current status of the Pi-Hole and fail2ban services, 
    any pending updates, and recent unattended upgrades

  $(usage)

  Options:
  -s  Display status of services: Pi-Hole ans fail2ban.
  -u  Display available updates and recent upgrades.
  -m  Display memory information.
  -h  Display this help message and exit.
  -v  Display current version of this utility.

_EOF_
}
## Help Related - End ##

make_pretty() {
  printf "\n%s\n\n" "****************************************************************************************"
}

check_status() {
  clear
  make_pretty
  get_fail2ban_client_status
  make_pretty
  get_pihole_status
  make_pretty
  get_memory_status
  make_pretty
}

show_updates() {
  clear
  make_pretty
  tail_unattended_upgrades_log
  make_pretty
  check_for_updates
  make_pretty
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
      check_status ;;
    u)
      show_updates ;;
    m)
      get_memory_status ;;
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