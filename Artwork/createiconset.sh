#!/bin/bash

PATH="$1";

if [ ! -d "$PATH" ]; then
	echo "Not a directory";
	exit;
fi;

if [ ! -f "$PATH/icon_16x16@2x.png" ]; then
	/bin/cp "$PATH/icon_32x32.png" "$PATH/icon_16x16@2x.png";
fi;

if [ ! -f "$PATH/icon_128x128@2x.png" ]; then
	/bin/cp "$PATH/icon_256x256.png" "$PATH/icon_128x128@2x.png";
fi;

if [ ! -f "$PATH/icon_256x256@2x.png" ]; then
	/bin/cp "$PATH/icon_512x512.png" "$PATH/icon_256x256@2x.png";
fi;

/usr/bin/iconutil -c icns "$PATH";
