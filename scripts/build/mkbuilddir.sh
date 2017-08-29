#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] ; then
	echo "At least one argument is empty"
	exit 1
fi

SOC="$1"
DEVICE="$2"

LEDE_REV="$3"
DL_CACHE="$4"

BUILD_DIR="build/$SOC/$DEVICE"

LEDE_GIT_URL="${5:-https://github.com/lede-project/source}"

[ -e "$BUILD_DIR" ] || {
	mkdir -p "$BUILD_DIR"
	git clone "$LEDE_GIT_URL" "$BUILD_DIR"
}

( cd "$BUILD_DIR" ; git checkout "$LEDE_REV" )

[ -d overlay ] && \
	cp -rf overlay/* "$BUILD_DIR"

rm -rf "$BUILD_DIR/dl"
ln -sf "$DL_CACHE" "$BUILD_DIR/dl"

rm -rf "$BUILD_DIR/files"
mkdir -p "$BUILD_DIR/files"
[ -d side/targets/generic/rootfs ] && \
	cp -rf side/targets/generic/rootfs/* "$BUILD_DIR/files"
[ -d side/targets/$SOC/$DEVICE/rootfs/* ] && \
	cp -rf side/targets/$SOC/$DEVICE/rootfs/* $BUILD_DIR/files

exit 0
