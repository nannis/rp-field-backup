# rp-field-backup
This is a project based on The Little Backup Box project which can be found here: https://chiselapp.com/user/dmpop/repository/little-backup-box/index
The code has been modified to work on a Raspberry Pi 3 together with an Adafruit 2.2'' TFT display.
Functionality added are:
* Debug print of then the script has started running, when a USB disk is connected, when a SD card is connected, when the sync has started, what it is syncing and when it is finished.
* The sync won't start until the button on pin #17 is pressed
* The unit is shut down when the buton on pin #27 is pressed (this comes with the display actually...)

Hardware needed
----------------
* Raspberry Pi 3 B+
* >=8GB Micro-SD card (To run the OS on the raspberry)
* PITFT Mini Kit 2.2'' Display from Adafruit (install required packages before installing the backup script!)
* Some kind of casing, e.g raspberry pi official case
* Some kind of USB storage
* SD card reader (USB)
* SD card


Installation instructions
--------------------------
 This script requires a bit more hands on intstallation than the regular project. Instead of running as a cronjob, the script should be configured to run automatically when logging in with the username pi (i.e. the default account.)

In order to get any meaningful output on the screen after boot up, it should be set to autologin and not to start up the full gui. To do this:
1. Open a terminal and type "sudo raspi-config" and press enter
2. Step down to option 3 (Boot Options) in the list and press enter
3. Step down to option B2 (Text console, automatically logged in as 'pi' user) and press enter
4. Step down to "OK" and press enter. You're now done setting up the automatic logon without full gui.

Before the next step, it is highly recommended to create another user who can run sudo before doing this. Information on how to do that can be found here: https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart.

To start up the script at login of user 'pi' (i.e. automatically if the steps above has been followed), do the following:
* Type "sudo nano .bashrc" in the terminal and press enter.
* Step down to the very end of the file.
* Add the full path to the backup file including the file name (in my case I added "/home/pi/little-backup-box/backup.sh" as that is where my script file is stored. /Anneli)
* Press Ctrl+X
* Type Y and press Enter when asked to save the changes.
* Press enter again to confirm the file name.
* The script will now run at the next reboot.

