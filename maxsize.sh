#!/bin/bash

# A script to calculate the largest files and directories in a specified directory
# Usage: ./maxsize.sh [-n number] [directory]

# Default number of items to display
count=10

# Parse command-line options
while getopts ':n:' OPTION; do
  # Handle arguments that require a value
  case "$OPTION" in # $OPTARG is the value that is passed to the option
    n)
      # Check if the value is an integer
      if [[ "$OPTARG" =~ ^[0-9]+$ ]]; then
        # Set the count to the provided value
        count="$OPTARG"
      else
        # Print an error message if the value is not an integer
        echo "Error: -n option requires an integer." >&2
        exit 1
      fi
      ;;
    ?)
      # Print usage information if an invalid option is provided
      echo "Usage: $(basename "$0") [-n number] [directory]" >&2
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
  # Print an error message and exit if the directory does not exist
  echo "The specified directory does not exist: $directory" >&2
  exit 1
fi

# Display the number of items to show
echo "Scanning $directory for the largest $count files and directories by size..."

# Function to display a spinner while the script is running
spin(){
  spinner="/|\\-/|\\-"
  while :
  do
    for i in $(seq 0 7)
    do
      echo -ne "${spinner:$i:1}"
      echo -ne "\010"
      sleep 0.2
    done
  done
}

# Run the spinner function in the background
spin &
SPIN_PID=$!
disown

# Find and sort the largest files
echo "Largest files:"
find "$directory" -type f -exec du -h {} + | sort -rh | head -n "$count"

# Calculate and display the total size of files directly in each directory (non-recursive)
echo "Directories with the most file size (non-recursive):"
# Loop through each subdirectory
while IFS= read -r dir; do
  # Calculate the total size of files in the directory
  total_size=$(find "$dir" -maxdepth 1 -type f -exec du -k {} + | awk '{sum += $1} END {print sum}')
  # Set total_size to 0 if it is not set
  total_size=${total_size:-0}  # Default to 0 if not set
  # Display the directory and total size if it is greater than 0
  if [ "$total_size" -gt 0 ]; then
    echo "$dir contains $total_size KB"
  fi
# Pass the list of directories to the while loop
done < <(find "$directory" -type d) | sort -k3 -nr | head -n "$count"

# Kill the spinner process
kill $SPIN_PID
wait $SPIN_PID 2>/dev/null

# Indicate that the operation is complete
echo "Operation completed."

# Exit with a successful status
exit 0
