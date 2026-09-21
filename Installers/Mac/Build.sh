#!/bin/zsh

# Requires macOS 26 or later

APPNAME="Beacon";
DEVID="Thom McGrath";
cd "$( dirname "${(%):-%x}" )"
SOURCE="../../Project/Builds - ${APPNAME}/macOS Universal";
DEST="/Volumes/${APPNAME}";
OUTPUT="Output";

if [ ! -d "${SOURCE}/${APPNAME}.app" ]; then
	echo "Make a build with Xojo first.";
	exit;
fi

mkdir -p "${OUTPUT}";

if [ -e "${OUTPUT}/${APPNAME}.asif" ]; then
	rm -rf "${OUTPUT}/${APPNAME}.asif";
fi
# bug: diskutil creates the wrong image when the source is a sparsebundle referenced by absolute path. The workaround is to use relative paths.
# alternatively, the source could be an asif format, but that gets stored as a single file which does not play as nicely with version control.
diskutil image create from "${APPNAME}.sparsebundle" "${OUTPUT}/${APPNAME}.asif";
diskutil image attach "${OUTPUT}/${APPNAME}.asif" --mountPoint "${DEST}" --nobrowse;
if [ -e "${DEST}/${APPNAME}.app/Contents" ]; then
	rm -rf "${DEST}/${APPNAME}.app/Contents";
fi
cp -R "${SOURCE}/${APPNAME}.app/Contents" "${DEST}/${APPNAME}.app";
find "${DEST}/${APPNAME}.app" -type d -exec chmod 755 {} +;
find "${DEST}/${APPNAME}.app" -type f -exec chmod 644 {} +;
chmod 755 "${DEST}/${APPNAME}.app/Contents/MacOS/${APPNAME}";
if [ -d "${DEST}/${APPNAME}.app/Contents/Frameworks/Sparkle.framework" ]; then
	chmod 755 "${DEST}/${APPNAME}.app/Contents/Frameworks/Sparkle.framework/Versions/B/Autoupdate";
	chmod 755 "${DEST}/${APPNAME}.app/Contents/Frameworks/Sparkle.framework/Versions/B/Updater.app/Contents/MacOS/Updater";
	chmod 755 "${DEST}/${APPNAME}.app/Contents/Frameworks/Sparkle.framework/Versions/B/XPCServices/org.sparkle-project.Downloader.xpc/Contents/MacOS/org.sparkle-project.Downloader";
	chmod 755 "${DEST}/${APPNAME}.app/Contents/Frameworks/Sparkle.framework/Versions/B/XPCServices/org.sparkle-project.InstallerLauncher.xpc/Contents/MacOS/org.sparkle-project.InstallerLauncher";
	chmod 755 "${DEST}/${APPNAME}.app/Contents/Frameworks/Sparkle.framework/Versions/B/Sparkle";
fi

diskutil eject "${DEST}";
if [ -e "${OUTPUT}/${APPNAME}.dmg" ]; then
	rm -rf "${OUTPUT}/${APPNAME}.dmg";
fi
diskutil image create from "${OUTPUT}/${APPNAME}.asif" "${OUTPUT}/${APPNAME}.dmg";
codesign -s "Developer ID Application: ${DEVID}" --timestamp "${OUTPUT}/${APPNAME}.dmg";
rm -rf "${OUTPUT}/${APPNAME}.asif";

echo "Uploading disk image for notarization. This can take a while.";
NOTARIZE_LOG="${TMPDIR}notarize_output";
xcrun notarytool submit "${OUTPUT}/${APPNAME}.dmg" --keychain-profile "${APPNAME}" --wait 2>&1 | tee "${NOTARIZE_LOG}";
NOTARIZE_RESULT=$?;
/bin/sync;
NOTARIZE_REQUEST_ID=$(sed -n 's/  id: \(.*\)/\1/p' "${NOTARIZE_LOG}" | head -n 1);
NOTARIZE_STATUS=$(sed -n 's/  status: \(.*\)/\1/p' "${NOTARIZE_LOG}" | tail -n 1);
if [ "${NOTARIZE_STATUS}" = "Accepted" ]; then
	NOTARIZE_COMPLETE=1;
	/bin/sync;
	xcrun stapler staple -v "${OUTPUT}/${APPNAME}.dmg";
	NOTARIZE_RESULT=$?;
	if [ $NOTARIZE_RESULT -eq 0 ]; then
		echo "Disk image is ready for shipping.";
		rm -f "${NOTARIZE_LOG}";
		/bin/sync;
		NOTARIZE_COMPLETE=2;
	else
		echo "Failed to staple disk image.";
		exit 1;
	fi
else
	if [ ! -z $NOTARIZE_REQUEST_ID ]; then
		xcrun notarytool log "${NOTARIZE_REQUEST_ID}" --keychain-profile "${APPNAME}" 2>&1 | tee "${NOTARIZE_LOG}";
	fi
	echo "Notarization error. Log path is ${NOTARIZE_LOG}";
	exit 1;
fi

exit 0;
