#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define imgname
$(BIN_DIR)/$(IMG_PREFIX)-$(2)-$(patsubst jffs2-%,jffs2,$(patsubst squashfs-%,squashfs,$(1)))
endef

define sysupname
$(call imgname,$(1),$(2))-sysupgrade.bin
endef

define factoryname
$(call imgname,$(1),$(2))-factory.bin
endef

zImage:=$(BIN_DIR)/$(IMG_PREFIX)-zImage

DTS_TARGETS = fsl/t4240rdb

define Image/BuildKernel
	cp $(KDIR)/zImage $(BIN_DIR)/$(IMG_PREFIX)-zImage
	$(foreach dts,$(DTS_TARGETS),
		$(LINUX_DIR)/scripts/dtc/dtc -I dts -O dtb $(DTS_DIR)/$(dts).dts > $(BIN_DIR)/$(IMG_PREFIX)-$(notdir $(dts)).fdt
	)
endef

define Image/BuildKernel/Initramfs
	cp $(KDIR)/zImage-initramfs $(BIN_DIR)/$(IMG_PREFIX)-initramfs-zImage
ifeq ($(SUBTARGET),generic)
	cp $(KDIR)/cuImage.tl-wdr4900-v1-initramfs $(BIN_DIR)/$(IMG_PREFIX)-tl-wdr4900-v1-initramfs.uImage
endif
endef

define Image/Build/squashfs
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	cp $(KDIR)/root.squashfs $(BIN_DIR)/$(IMG_PREFIX)-root.squashfs
endef

define Image/Build
	$(call Image/Build/$(1),$(1))
endef

$(eval $(call BuildImage))
