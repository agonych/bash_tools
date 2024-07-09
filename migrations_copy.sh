#!/bin/bash

# A script to copy all "migrations" directories from a Django app
# Will find and copy migrations from a source directory to a target directory
# Usage: ./migrations_copy.sh <source_base_dir> <target_base_dir>
# Example: ./migrations_copy.sh ~/projects ~/backup/projects

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_base_dir> <target_base_dir>"
  exit 1
fi

# Assign the arguments to variables
SRC_BASE_DIR=$1
TARGET_BASE_DIR=$2

# Create the target base directory if it does not exist
mkdir -p "$TARGET_BASE_DIR"

# Find all "migrations" directories and copy them to the target directory
find "$SRC_BASE_DIR" -type d -name "migrations" | while read SRC_DIR; do
  # Determine the relative path of the "migrations" directory
  REL_PATH="${SRC_DIR#$SRC_BASE_DIR/}"

  # Construct the target directory path
  TARGET_DIR="$TARGET_BASE_DIR/$REL_PATH"

  # Create the target directory
  mkdir -p "$TARGET_DIR"

  # Copy the contents of the "migrations" directory to the target directory
  cp -r "$SRC_DIR/"* "$TARGET_DIR/"
done

echo "All migrations folders have been copied to $TARGET_BASE_DIR"
