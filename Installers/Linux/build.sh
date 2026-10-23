#!/bin/zsh

APPNAME="Beacon";
cd "$( dirname "${(%):-%x}" )";

mkdir -p "output/x64";
mkdir -p "output/arm64";

ARCHIVE_X64="output/x64/beacon.tgz";
ARCHIVE_ARM64="output/arm64/beacon.tgz";

if [ -e "${ARCHIVE_X64}" ]; then
	rm "${ARCHIVE_X64}";
fi
if [ -e "${ARCHIVE_ARM64}" ]; then
	rm "${ARCHIVE_ARM64}";
fi

tar -czvhf "${ARCHIVE_X64}" --exclude='.DS_Store' --disable-copyfile --no-xattrs -C "files" "." -C "../../../Project/Builds - ${APPNAME}/Linux 64 bit" "${APPNAME}";
tar -czvhf "${ARCHIVE_ARM64}" --exclude='.DS_Store' --disable-copyfile --no-xattrs -C "files" "." -C "../../../Project/Builds - ${APPNAME}/Linux ARM64" "${APPNAME}";
