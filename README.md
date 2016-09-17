# rp-field-backup
# This is a project based on The Little Backup Box project which can be found here: https://chiselapp.com/user/dmpop/repository/little-backup-box/index
# The code has been modified to work on a Raspberry Pi 3 together with an Adafruit 2.2'' TFT display.
# Functionality added are:
#  * Debug print of then the script has started running, when a USB disk is connected, when a SD card is connected, when the sync has started, what it is syncing and when it is finished.
#  * The sync won't start until the button on pin #17 is pressed
#  * The unit is shut down when the buton on pin #27 is pressed (this comes with the display actually...)
#

#Installation instructions
#--------------------------
# This script requires a bit more hands on intstallation than the regular project. Instead of running as a cronjob, the script should be configured to run automatically when logging in with the username pi (i.e. the default account.)
#
# In order to get any meaningful output on the screen after boot up, it should be set to autologin and not to start up the full gui. To do this:
# 1) Open a terminal and type "sudo raspi-config" and press enter
# 2) Step down to option 3 (Boot Options) in the list and press enter
# 3) Step down to option B2 (Text console, automatically logged in as 'pi' user) and press enter
# 4) Step down to "OK" and press enter. You're now done setting up the automatic logon without full gui.
#
# To start up the script at login of user 'pi' (i.e. automatically if the steps above has been followed), do the following:
# 1) Type "sudo nano .bashrc" in the terminal and press enter.
# 2) Step down to the very end of the file.
# 3) Add the full path to the backup file including the file name (in my case I added "/home/pi/little-backup-box/backup.sh" as that is where my script file is stored. /Anneli)
# 4) Press Ctrl+X
# 5) Type Y and press Enter when asked to save the changes.
# 6) Press enter again to confirm the file name.
# 7) The script will now run at the next reboot.
