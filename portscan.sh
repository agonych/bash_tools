#!/bin/bash

# A script to scan open ports and the applications listening on them
# Usage: ./portscan.sh

echo "Scanning open ports and the applications listening on them..."

# Check if 'ss' command is available, which is the modern replacement for 'netstat'
if command -v ss &> /dev/null; then
    # Use 'ss' to display open ports with their associated applications
    echo "Using 'ss' command..."
    ss -tulwn | awk 'NR > 1 {print $1, $5, $6}' | while read proto local remote; do
        pid=$(echo $remote | grep -oP '.*?(?==)')
        app=$(echo $remote | grep -oP '(?<=\=).*')
        echo -e "Protocol: $proto\nLocal Address: $local\nPID/Application: $app ($pid)\n"
    done
else
    # Fallback to 'netstat' if 'ss' is not available
    echo "Using 'netstat' command..."
    netstat -tulnep | awk 'NR > 2 {print $1, $4, $9}' | while read proto local piduser; do
        pid=$(echo $piduser | cut -d'/' -f1)
        app=$(echo $piduser | cut -d'/' -f2)
        echo -e "Protocol: $proto\nLocal Address: $local\nPID/Application: $app ($pid)\n"
    done
fi

echo "Scan completed."
