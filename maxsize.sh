#!/bin/bash

# A script to calculate the largest files and directories in a specified directory
# Usage: ./maxsize.sh [-n number] [directory]

# Default number of items to display
count=10

# Parse command-line options
while getopts 'n:' OPTION; do
  case "$OPTION" in
    n)
      count="$OPTARG"
      ;;
    ?)
      echo "Usage: $(basename "$0") [-n number] [directory]"
      exit 1
      ;;
  esac
done

# Remove the options from the positional parameters
shift "$((OPTIND -1))"

# Use the current directory if none is provided
directory="${1:-.}"

# Check if the specified directory exists
if [[ ! -d "$directory" ]]; then
  echo "The specified directory does not exist: $directory"
  exit 1
fi

echo "Scanning $directory for the largest $count files and directories by size..."

# Find and sort the largest files
echo "Largest files:"
find "$directory" -type f -exec du -h {} + | sort -rh | head -n "$count"

# Calculate and display the total size of files directly in each directory (non-recursive)
echo "Directories with the most file size (non-recursive):"
find "$directory" -type d | while read dir; do
  total_size=$(find "$dir" -maxdepth 1 -type f -exec du -k {} + | awk '{sum += $1} END {print sum}')
  if [ "$total_size" -gt 0 ]; then  # Only print directories with size greater than 0 KB
    echo "$dir contains $total_size KB"
  fi
done | sort -k3 -nr | head -n "$count"
