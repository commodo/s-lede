#
# Copyright (C) 2017 Side LEDE
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

default: help

LEDE_GIT_URL:=https://github.com/lede-project/source
PACKAGES_GIT_URL:=https://github.com/openwrt/packages

LEDE_REV:=v17.01.3
PACKAGES_REV:=lede-17.01

SIDE_PACKAGE_DIR:=side/packages

DL_CACHE ?= ../../dl-cache

target_prepare_base:
	[ "$(DL_CACHE)" != "../../dl-cache" ] || [ -d dl-cache ] || mkdir dl-cache

NOT_PARALLEL_BUILDS:= \
	target_prepare_base

style:
	@if astyle --help > /dev/null 2>&1 ; then \
		astyle --recursive --options=.astyle side/packages/*.c side/packages/*.h ; \
		exit 0 ; \
	else \
		echo "No astyle tool found" ; \
	fi

define iterate_devices
$(foreach soc,$(shell ls side/targets),$(foreach device,$(shell ls side/targets/$(soc)),$(call $(1),$(soc),$(device))))
endef

define print_device
printf "\ttarget/$(1)/$(2)\n";)
endef

help:
	@echo "side-lede platforms:"
	@$(call iterate_devices,print_device)

define target_template

target/$(1)/$(2)/mkbuildir: target_prepare_base
	./scripts/build/mkbuilddir.sh $(1) $(2) $(LEDE_REV) $(DL_CACHE) $(LEDE_GIT_URL)

target/$(1)/$(2)/feeds: target/$(1)/$(2)/mkbuildir
	./scripts/build/feeds.sh $(1) $(2) $(PACKAGES_REV) $(PACKAGES_GIT_URL)

target/$(1)/$(2)/config: target/$(1)/$(2)/feeds
	cp -f side/targets/$(1)/$(2)/config build/$(1)/$(2)/.config

target/$(1)/$(2)/defconfig: target/$(1)/$(2)/config
	make -C build/$(1)/$(2) defconfig
	cp -f build/$(1)/$(2)/.config side/targets/$(1)/$(2)/config

target/$(1)/$(2)/menuconfig: target/$(1)/$(2)/config
	make -C build/$(1)/$(2) menuconfig
	cp -f build/$(1)/$(2)/.config side/targets/$(1)/$(2)/config

target/$(1)/$(2): target/$(1)/$(2)/defconfig
	+make -C build/$(1)/$(2)

NOT_PARALLEL_BUILDS+= \
	target/$(1)/$(2)/mkbuildir \
	target/$(1)/$(2)/feeds \
	target/$(1)/$(2)/config \
	target/$(1)/$(2)/defconfig \
	target/$(1)/$(2)/menuconfig \

endef

$(eval $(call iterate_devices,target_template))

define build_dep
$(1)/$(2)
endef

define build_dep_defconfig
target/$(1)/$(2)/defconfig
endef

targets: $(call iterate_devices,build_dep)

all/defconfig: $(call iterate_devices,build_dep_defconfig)

.NOTPARALLEL: $(NOT_PARALLEL_BUILDS)

