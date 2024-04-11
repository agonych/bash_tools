#!/bin/bash

# A script to monitor a specific process using top, useful for debugging or maintenance.
# Usage: ./procwatch.sh process_name

process=$1

if [[ -z "$process" ]]; then
  echo "Usage: $(basename "$0") process_name"
  exit 1
fi

# Monitor the process
echo "Monitoring $process..."
top -b -n 1 | grep "$process"
