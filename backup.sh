#!/bin/bash
read -s -p "enter password: " pass
echo

BORG_PASSPHRASE=$pass borg create -v \
    --stats --progress --one-file-system --compression zlib,5 \
    16385@ch-s010.rsync.net:backup::'{hostname}-{now:%Y-%m-%d}' \
    /home/danieln/work /home/danieln/code \
    /home/danieln/documents /home/danieln/logbook \
    /home/danieln/notes /home/danieln/.gnupg/ # /home/danieln/pictures

BORG_PASSPHRASE=$pass borg prune -v 16385@ch-s010.rsync.net:backup --prefix '{hostname}-' --keep-daily=7 --keep-weekly=4 --keep-monthly=6
