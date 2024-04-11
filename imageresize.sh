#!/bin/bash

# A script to batch resize images in a directory using ImageMagick
# Usage: ./imageresize.sh directory new_width

dir=$1
width=$2

if [[ ! -d "$dir" || -z "$width" ]]; then
  echo "Usage: $(basename "$0") directory new_width"
  exit 1
fi

# Resize images
echo "Resizing images in $dir to width $width pixels..."
mogrify -resize "${width}x" "$dir"/*.{jpg,png,gif}
echo "Resize completed."
