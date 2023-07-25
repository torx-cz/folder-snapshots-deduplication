#!/bin/sh

# Function to compare two directories using diff
compare_directories() {
  diff -r "$1" "$2" > /dev/null
}

# Check if the -f or --force flag is provided to indicate removal
remove_duplicates=false
if [ "$1" = "-f" ] || [ "$1" = "--force" ]; then
  echo "NOTE: Running in FORCE mode. Duplicate folder will be removed!!"
  sleep 5

  remove_duplicates=true
  shift
fi

# Check if the snapshot directory path is provided as an argument
if [ -z "$1" ]; then
  echo "Error: Please provide the path to the snapshot directory."
  echo "Usage: $0 [--force|-f] /path/to/snapshots"
  exit 1
fi

# Set the path to the directory containing your snapshots
snapshot_dir="$1"

# Check if the snapshot directory exists
if [ ! -d "$snapshot_dir" ]; then
  echo "Error: Snapshot directory not found or is not a directory."
  exit 1
fi

# Change directory to the snapshot location
cd "$snapshot_dir" || exit 1

# Loop through all folders in the snapshot directory
for folder1 in */; do
  echo "Base folder for comparison: $folder1"

  for folder2 in */; do

    # Skip comparing the same folder
    if [ "$folder1" = "$folder2" ]; then
      continue
    fi

    # Compare the two folders
    if ! compare_directories "$folder1" "$folder2"; then
      continue
    fi

    # Duplicate found
    if $remove_duplicates; then
      # Perform removal if --force or -f flag is set
      echo "  Removing duplicate: $folder2"
      rm -rf "$folder2"
    else
      # Dry-run, show which duplicates would be removed
      echo "  Duplicate found (dry-run): $folder2"
    fi

  done
done

if $remove_duplicates; then
  echo "Duplicate removal process completed."
else
  echo "Dry-run completed. Use --force or -f option to perform removal."
fi
