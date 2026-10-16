#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# menu module
# ---------------------------------------------------------------------------

menu() {
  clear
  PS3="Enter a number: "

  select func in status update help quit; do

    case $func in
      status)
        check_status; exit 0 ;;
      update)
        show_updates; exit 0 ;;
      help)
        help_message; exit 0 ;;
      quit)
        printf "Good-bye!"; exit 0 ;;
      *)
        printf "ERROR: Invalid option %s\n" "$REPLY"; exit 1 ;;
    esac
  
  done
}