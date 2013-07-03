#!/bin/bash
#Creates a timelapse of the SAU 1 cam pointing at the Polisseni Center

#Check if user is root
#Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
#Scrub bad timelapse framez
ruby detect-bad-timelapse-frames.rb /mnt/icelab-timelapse/SAU-timelapse-daily/ /home/user/temp/ /home/user/temp/

#Generates a filename for the final video
FILENAME="poli1-timelapse-`date +%Y%m%d`"

#produces a .h264 file from various.png images
mencoder "mf:///mnt/icelab-timelapse/SAU-timelapse-daily/SAU_233.17.33.206.50004_*/*.png" -mf type=png:fps=30 -ovc x264 -of lavf -o /mnt/icelab-videos/SAU-timelapse-videos/$FILENAME.h264

#Converts the .h264 file into a .mp4 file
ffmpeg -i /mnt/icelab-videos/SAU-timelapse-videos/$FILENAME.h264 /mnt/icelab-videos/SAU-timelapse-videos/$FILENAME.mp4

#Removes the old .h264 file
rm /mnt/icelab-videos/SAU-timelapse-videos/$FILENAME.h264

