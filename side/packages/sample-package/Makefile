#
# Copyright (C) 2017 Side LEDE
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sample_app
PKG_VERSION:=0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/sample_app
  SECTION:=slede
  CATEGORY:=Side LEDE Stuff
  TITLE:=Sample Application
  DEPENDS:=+libjson-c
endef

define Package/sample_app/description
  Sample Application
endef

define Package/sample_app/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sample_app $(1)/usr/bin
endef

$(eval $(call BuildPackage,sample_app))
