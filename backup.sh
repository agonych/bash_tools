#!/bin/bash

# A simple script to back up a directory using rsync
# Usage: ./backup.sh source_directory target_directory

source=$1
target=$2

if [[ -z "$source" || -z "$target" ]]; then
  echo "Usage: $(basename "$0") source_directory target_directory"
  exit 1
fi

# Create the target directory if it doesn't exist
mkdir -p "$target"

# Perform the backup
rsync -avh --progress "$source" "$target"

echo "Backup of $source completed successfully."
