BOARDNAME:=T4240 RDB (64 bit BE)
FEATURES:=squashfs powerpc64 rtc ubifs
MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>

ARCH:=powerpc64

DEFAULT_PACKAGES += kmod-rtc-ds1374 \
                    kmod-usb2 kmod-usb2-fsl

define Target/Description
	Build firmware images for Freescale T4240 based boards.
endef

