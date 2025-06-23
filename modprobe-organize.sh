#!/bin/bash

# Define variables
mdb="minimal-modprobed.db"
mdbf="minimal-modprobed-final.db"
mdbb="minimal-modprobed.db.bak"

# Optional: enable nullglob so the wildcard doesn't literally return '*-TKT-modules-list.txt' if nothing matches
shopt -s nullglob
files=(*-TKT-modules-list.txt)

# Check if we have any input files
if (( ${#files[@]} == 0 )); then
  echo "No module list files found. Exiting."
  exit 1
fi

echo "Making a backup of the $mdb file..."
cp "$mdb" "$mdbb"

echo "Combining all the modprobed.db modules..."
cat "${files[@]}" >> "$mdb"
rm -f "${files[@]}"

echo "Sorting the modprobed.db modules..."
sort -u "$mdb" -o "$mdbf"

echo "Moving the sorted modules list back to $mdb..."
mv "$mdbf" "$mdb"
