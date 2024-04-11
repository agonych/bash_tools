#!/bin/bash

# A script to list directories in a given path sorted by their disk usage, useful for cleaning up disks.
# Usage: ./dirsize.sh [directory]

directory="${1:-.}"

# Validate the directory path
if [[ ! -d "$directory" ]]; then
  echo "Invalid directory: $directory"
  exit 1
fi

# List directories sorted by size
du -sh "$directory"/* | sort -rh | head -20
