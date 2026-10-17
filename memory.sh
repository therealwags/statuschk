#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# memory module
# ---------------------------------------------------------------------------

# Display free and used memory in the system
get_memory_status() {
  printf "Current free and used memory:\n\n"
  free -hlw --
}