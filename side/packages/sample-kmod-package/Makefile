include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sample_kmod_app
PKG_VERSION:=0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/sample_kmod_app
	SECTION:=slde
	CATEGORY:=Side LEDE Stuff
	TITLE:=Sample kmod App
	FILES:= \
		$(PKG_BUILD_DIR)/sample_kmod_app.$(LINUX_KMOD_SUFFIX)
	DEPENDS:=kmod-ipt-conntrack-extra
	AUTOLOAD:=$(call AutoLoad,95,sample_kmod_app)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/sample_kmod_app/description
  Sample kmod App
endef

TARGET_CFLAGS += \
	-D_GNU_SOURCE
define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" modules
endef

$(eval $(call KernelPackage,sample_kmod_app))
