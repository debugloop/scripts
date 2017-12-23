#!/bin/bash
read -s -p "enter password: " pass
echo

BORG_PASSPHRASE=$pass BORG_RSH="ssh -i ~/.ssh/id_danieln" borg create -v --stats --progress --one-file-system \
    --compression zlib,5 \
    -e 'sh:/home/danieln/Desktop' \
    -e 'sh:/home/danieln/Downloads' \
    --exclude-from '/home/danieln/scripts/EXCLUDE' \
    16385@ch-s010.rsync.net:borg::'{hostname}-{now:%Y-%m-%d}' /home/danieln/ /home/danieln/.config/ /home/danieln/.gnupg/

BORG_PASSPHRASE=$pass BORG_RSH="ssh -i ~/.ssh/id_danieln" borg prune -v 16385@ch-s010.rsync.net:borg --prefix '{hostname}-' --keep-daily=7 --keep-weekly=4 --keep-monthly=6
