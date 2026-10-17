#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# services module
# ---------------------------------------------------------------------------

# Display current Pi-Hole status
get_pihole_status() {
  printf "Current Pi-Hole Status:\n\n"
  sudo pihole status verbose
}

# Display current fail2ban client status
get_fail2ban_client_status() {
  printf "Current fail2ban client status:\n\n"
  sudo fail2ban-client status sshd
}