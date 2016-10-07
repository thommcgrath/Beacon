#!/bin/bash

APPNAME="Beacon";
PARENT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
SOURCE="${PARENT}/../../Project/Builds - Beacon.xojo_project/Mac OS X (Cocoa Intel)";
DEST="/Volumes/${APPNAME}";
OUTPUT="${PARENT}/Output";

if [ ! -d "${SOURCE}/${APPNAME}.app" ]; then
	echo "Make a client build with Xojo first.";
	exit;
fi

mkdir -p "${OUTPUT}";

hdiutil convert "${PARENT}/${APPNAME}.sparsebundle" -format UDSP -o "${OUTPUT}/${APPNAME}.sparseimage";
hdiutil mount "${OUTPUT}/${APPNAME}.sparseimage";
if [ -e "${DEST}/${APPNAME}.app/Contents" ]; then
	rm -rf "${DEST}/${APPNAME}.app/Contents";
fi
cp -R "${SOURCE}/${APPNAME}.app/Contents" "${DEST}/${APPNAME}.app";
find "${DEST}/${APPNAME}.app" -type d -exec chmod 755 {} +;
find "${DEST}/${APPNAME}.app" -type f -exec chmod 644 {} +;

hdiutil eject "${DEST}";
if [ -e "${OUTPUT}/${APPNAME}.dmg" ]; then
	rm -rf "${OUTPUT}/${APPNAME}.dmg";
fi
hdiutil convert "${OUTPUT}/${APPNAME}.sparseimage" -format UDBZ -o "${OUTPUT}/${APPNAME}.dmg";
hdiutil internet-enable -yes "${OUTPUT}/${APPNAME}.dmg";
rm -rf "${OUTPUT}/${APPNAME}.sparseimage";
