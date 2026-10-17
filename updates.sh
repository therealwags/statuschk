#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# updates module
# ---------------------------------------------------------------------------

# Check if updates are needed
check_for_updates() {
  printf "Checking for updates:\n\n"
  sudo apt update
}

# tail Unattended Upgrades log
tail_unattended_upgrades_log() {
  printf "Latest unattended upgrade entries:\n\n"
  sudo tail -n 25 /var/log/unattended-upgrades/unattended-upgrades-dpkg.log

  # if [ -z "$1" ]; then
  #   sudo tail -n 25 /var/log/unattended-upgrades/unattended-upgrades-dpkg.log
  # fi
  # sudo tail -n "$1" /var/log/unattended-upgrades/unattended-upgrades-dpkg.log
}