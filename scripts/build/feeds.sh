#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ; then
	echo "At least one argument is empty"
	exit 1
fi

SOC=$1
DEVICE=$2

PACKAGES_REV="$3"

BUILD_DIR="build/$SOC/$DEVICE"
PACKAGES_GIT_URL="${4:-https://github.com/openwrt/packages}"

echo "src-git packages ${PACKAGES_GIT_URL}^${PACKAGES_REV}" > $BUILD_DIR/feeds.conf
echo "src-link side_packages `readlink -f side/packages`" >> $BUILD_DIR/feeds.conf

$BUILD_DIR/scripts/feeds update
$BUILD_DIR/scripts/feeds install -a

exit 0
