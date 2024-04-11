#!/bin/bash

# A script to gather and output system information
# Usage: ./sysinfo.sh

echo "Gathering system information..."

# Display the hostname
echo "Hostname: $(hostname)"

# Display system uptime
echo "Uptime: $(uptime -p)"

# Display currently logged-in users
echo "Logged-in users:"
who

# Display memory usage
echo "Memory Usage:"
free -h

# Display disk usage
echo "Disk Usage:"
df -h

# Display load averages
echo "Load Averages:"
uptime
