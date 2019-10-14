#!/bin/bash

APPNAME="Beacon";
PARENT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
SOURCE="${PARENT}/../../Project/Builds - Beacon.xojo_project/OS X 64 bit";
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
chmod 755 "${DEST}/${APPNAME}.app/Contents/MacOS/${APPNAME}";

hdiutil eject "${DEST}";
if [ -e "${OUTPUT}/${APPNAME}.dmg" ]; then
	rm -rf "${OUTPUT}/${APPNAME}.dmg";
fi
hdiutil convert "${OUTPUT}/${APPNAME}.sparseimage" -format UDBZ -o "${OUTPUT}/${APPNAME}.dmg";
codesign -s 'Developer ID Application: Thom McGrath' --timestamp "${OUTPUT}/${APPNAME}.dmg";
rm -rf "${OUTPUT}/${APPNAME}.sparseimage";

echo "Uploading disk image for notarization. This can take a while.";
APPLEID=$(security find-generic-password -s "App Notarization" | sed -n 's/^[[:space:]]*"acct"<blob>="\(.*\)"/\1/p');
TEAMID=$(security find-generic-password -s "App Notarization" | sed -n 's/^[[:space:]]*"icmt"<blob>="\(.*\)"/\1/p');
xcrun altool --notarize-app --file "${OUTPUT}/${APPNAME}.dmg" --primary-bundle-id com.thezaz.beacon --username "${APPLEID}" --password @keychain:"App Notarization" --asc-provider "${TEAMID}" > ${TMPDIR}notarize_output 2>&1 || { rm -f ${TMPDIR}notarize_output; echo "Failed to upload disk image for notarization"; exit $?; };
REQUESTUUID=$(sed -n 's/RequestUUID = \(.*\)/\1/p' ${TMPDIR}notarize_output);
echo "Disk image has been uploaded. Request UUID is ${REQUESTUUID}. Checking status every 10 seconds...";
STATUS="in progress";
while [ "${STATUS}" = "in progress" ]; do
	sleep 10s;
	xcrun altool --notarization-info "${REQUESTUUID}" --username "${APPLEID}" --password @keychain:"App Notarization" --asc-provider "${TEAMID}" > ${TMPDIR}notarize_output 2>&1 || { rm -f ${TMPDIR}notarize_output; echo "Failed to check on notarization status."; exit $?; };
	STATUS=$(sed -ne 's/^[[:space:]]*Status: \(.*\)$/\1/p' ${TMPDIR}notarize_output);
done;
rm -f ${TMPDIR}notarize_output;
if [ "${STATUS}" = "success" ]; then
	xcrun stapler staple -v "${OUTPUT}/${APPNAME}.dmg";
else
	echo "Disk image was not notarized, status is ${STATUS}.";
	echo "See 'xcrun altool --notarization-info \"${REQUESTUUID}\" --username \"${APPLEID}\" --password @keychain:\"App Notarization\" --asc-provider \"${TEAMID}\"'";
	exit 1;
fi;

echo "Disk image is ready for shipping.";
exit 0;
