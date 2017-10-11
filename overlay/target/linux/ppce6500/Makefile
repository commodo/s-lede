#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

BOARD:=ppce6500
BOARDNAME:=Freescale QorIQ family (powerpc)
CPU_TYPE:=ppce6500
FEATURES:=squashfs nand usb pcie gpio
MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>
SUBTARGETS:=t4240_64b

KERNEL_PATCHVER:=4.4

define Target/Description
	Build images for the Freescale AMP Series based boards.
endef

include $(INCLUDE_DIR)/target.mk

KERNEL_IMAGES := zImage

DEFAULT_PACKAGES += kmod-usb-storage

$(eval $(call BuildTarget))
