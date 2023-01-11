#! /usr/bin/env bash

BASE_DIR="$HOME/Videos"

# Do Forever
while true
do
	# sleep until a disk is inserted
	until sudo blkid /dev/sr0 > /dev/null
	do
		sleep 10
	done

	# Find the disc label using blkid and save to var
	DISC_LABEL=$(sudo blkid /dev/sr0 | awk '{print $3}' | awk -F "=" '{gsub(/"/, "", $2); print $2}')
	echo "$DISC_LABEL"

	# remove any existing backups of disc
	rm -rf  "$BASE_DIR/$DISC_LABEL.iso"

	# make disc backup, then eject disk
	makemkvcon backup disc:/dev/sr0 "$BASE_DIR/$DISC_LABEL.iso"
	eject
	sleep 10
done

