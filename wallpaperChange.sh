#! /bin/bash
# Purpose: To change the wallpaper after certain period of time.

exec 2>/dev/null
dir=/home/green/Pictures/SimpleDesktops

files=$(ls $dir/*.{png,jpg,jpeg})

while true
do
	for currentWall in $files
	do
		gsettings set org.gnome.desktop.background picture-uri file://$currentWall
		sleep 600
	done
done
