# Snapshot Deduplication Script

The `deduplicate_snapshots.sh` script is a shell script designed to help deduplicate daily snapshots of a folder. It compares the contents of each snapshot and removes folders that are identical to others, thereby optimizing storage space.

### Prerequisites

This script requires a Unix-like environment with a shell interpreter (e.g., Bash, Dash).
Ensure you have the necessary permissions to execute the script and modify the snapshot directories.


### Usage

```sh
./deduplicate_snapshots.sh [--force|-f] /path/to/snapshots
```
- `--force` or `-f`: \[Optional\] Flag to force the removal of duplicate folders. If provided, the script will perform the actual deletion of duplicates.
- `/path/to/snapshots`: The path to the directory containing the daily snapshots. This argument is **required**.

### How It Works

The script works by comparing the content of each folder in the snapshot directory using the `diff` command. It identifies duplicates and, if the `--force` or `-f` flag is set, removes them to save storage space.

#### Dry-Run Mode:
When executed without the `--force` or `-f` flag, the script runs in **dry-run** mode. It displays a list of duplicate folders that would be removed if the `--force` or `-f` flag was provided, but it does not perform the actual deletion.

#### Removal Mode:
If the `--force` or `-f` flag is provided, the script proceeds to remove duplicate folders, freeing up space by keeping only unique snapshots.

### Examples

To perform a dry-run:

```sh
./deduplicate_snapshots.sh ./test-data

# OUTPUT:
#
# Base folder for comparison: snapshot-1/
#   Duplicate found (dry-run): snapshot-2/
# Base folder for comparison: snapshot-2/
#   Duplicate found (dry-run): snapshot-1/
# Base folder for comparison: snapshot-3/
# Base folder for comparison: snapshot-4/
#   Duplicate found (dry-run): snapshot-5/
# Base folder for comparison: snapshot-5/
#   Duplicate found (dry-run): snapshot-4/
# -----
# Dry-run completed. Use --force or -f option to perform removal.

```



To perform the removal:

```sh
./deduplicate_snapshots.sh --force ./test-data
```

or

```sh
./deduplicate_snapshots.sh -f ./test-data

# OUTPUT:
#
# NOTE: Running in FORCE mode. Duplicate folder will be removed!!
# Base folder for comparison: snapshot-1/
#   Removing duplicate: snapshot-2/
# Base folder for comparison: snapshot-3/
# Base folder for comparison: snapshot-4/
#   Removing duplicate: snapshot-5/
# -----
# Duplicate removal process completed.

```

### Important Note
Use this script with caution, as it involves **removing data**. Ensure you have backed up your snapshots or have a recovery plan in place.

Always double-check the script and its output before running with the `--force` flag to avoid **unintended data loss**.

### License

This script is released under the **MIT License**.
