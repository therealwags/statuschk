# StatusChk
Display current status of the Pi-Hole and fail2ban services, any pending updates, and recent unattended upgrades.

###### Note: Designed for use with a Debian 13 (trixie) server with the named services installed and in use.

## Usage: [^1]
- statuschk.sh [ -s | services ]
- statuschk.sh [ -u | updates ]
- statuschk.sh [ -m | memory info ]
- statuschk.sh [ -h | help ]
- statuschk.sh [ -v | version ]

### Notes:
- v2.0: split into modules
- v1.7: reformat README using markdown
- v1.6: added option m to display memory information (free)
- v1.5: added menu and getops options u (updates) & s (status)
- v1.0: added getops options h (help) & v (version)
- v0.5: initial script design that always ran everything

###### *© 2026 Wags*

[^1]: Adding the following to *.bashrc* may allow for using *statuschk* command, with or without options, anywhere

    if [ "$#" -eq 0 ]; then
        bash { path to script }
    fi

    for item in "$@"; do "{ path to script }" "$item"; done;