#!/bin/bash

# IMPORTANT:
# Run the install-little-backup-box.sh script first
# to install the required packages and configure the system.

# Henriks input:
if pidof -o %PPID -x /home/pi/little-backup-box/backup.sh > /dev/null ; then
        echo "backup.sh is already running!"
        exit
fi

# Specify devices and their mount points
STORAGE_DEV="sda1"
STORAGE_MOUNT_POINT="/media/storage"
CARD_DEV="sdb1"
CARD_MOUNT_POINT="/media/card"

# Does not work for Pi3 so I disabled it
# Set the ACT LED to heartbeat
# sudo sh -c "echo heartbeat > /sys/class/leds/led0/trigger"

# Preparing the button for use (the leftmost button under the display)
sudo echo 17 > /sys/class/gpio/export
sudo gpio -g mode 17 up
echo "Gpio export set"
BUTTON=$(cat /sys/class/gpio/gpio17/value)
echo "Button value " $BUTTON

echo Start

# Wait for a USB storage device (e.g., a USB flash drive)
STORAGE=$(ls /dev/* | grep $STORAGE_DEV | cut -d"/" -f3)
while [ -z ${STORAGE} ]
  do
  sleep 1
  STORAGE=$(ls /dev/* | grep $STORAGE_DEV | cut -d"/" -f3)
done

# When the USB storage device is detected, mount it
sudo mount /dev/$STORAGE_DEV $STORAGE_MOUNT_POINT
echo "USB storage mounted"

# Wait for a card reader or a camera
CARD_READER=$(ls /dev/* | grep $CARD_DEV | cut -d"/" -f3)
until [ ! -z $CARD_READER ]
  do
  sleep 1
  CARD_READER=$(ls /dev/sd* | grep $CARD_DEV | cut -d"/" -f3)
done

# If the card reader is detected, mount it and obtain its UUID
if [ ! -z $CARD_READER ]; then
  sudo mount /dev/$CARD_DEV $CARD_MOUNT_POINT
  echo "SD card connected"

# Wait for the button to be pressed

until [ "$BUTTON" = "0" ]
do
        sleep 1
        BUTTON=$(cat /sys/class/gpio/gpio17/value)
done

# Create the CARD_ID file containing a random 8-digit identifier if doesn't exist
  if [ ! -f $CARD_MOUNT_POINT/CARD_ID ]; then
    < /dev/urandom tr -cd 0-9 | head -c 8 > $CARD_MOUNT_POINT/CARD_ID
  fi
  # Read the 8-digit identifier number from the CARD_ID file on the card
  # and use it as a directory name in the backup path
  read -r ID < $CARD_MOUNT_POINT/CARD_ID
  BACKUP_PATH=$STORAGE_MOUNT_POINT/"$ID"

# Perform backup using rsync
echo "Backup started..."
sudo rsync -avh $CARD_MOUNT_POINT/ $BACKUP_PATH

echo "Backup completed"

fi

# To unmount the SD card and USB storage
umount $STORAGE_MOUNT_POINT
umount $CARD_MOUNT_POINT
echo "USB and SD card unmounted"

# Shutdown
sync
#sudo  shutdown -h now
