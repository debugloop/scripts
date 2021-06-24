#!/usr/bin/env fish

cd /home/danieln


notify-send -t 0 "Backup started" "Daily run, keep laptop on for a while."

source .restic

set old_size (restic stats --mode raw-data | grep "Total Size" | cut -d':' -f2 | string trim)

restic backup \
    --verbose \
    --one-file-system \
    --tag daily \
    --option b2.connections=50 \
    --files-from .restic-files
    --iexclude-file .restic-excludes

restic forget \
    --verbose \
    --tag daily \
    --option b2.connections=50 \
    --prune \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 3 \
    --keep-yearly 1

set size (restic stats --mode raw-data | grep "Total Size" | cut -d':' -f2 | string trim)

notify-send -t 0 "Backup finished" "New size is $size, old size was $old_size."
