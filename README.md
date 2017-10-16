Side LEDE Project
=============================================

Personal overlay of things that I add(ed) on top of the LEDE/OpenWrt project.

That way I can just add my stuff at the rate I want, and not hold it
on my computer waiting for a power outage to fry my computer.

Basic mode of operation:
* keep a set of small build rules that just patch copy stuff over LEDE/OpenWrt
* clone official LEDE/OpenWrt repos and patch/extend them
* I care about a few targets [for various reasons] ; hold only these here

Building/using the T4240 image
---------------------------------------------

Currently only there is only the RAM FS image. Hopefully there will be time to do the SD-card image.

Setup your build environment as you normally do on your Linux distro.
Example for Linux: build-essentials, git, libncurses-dev.

The build will fail and notify you when it does not find parts that are needed for the build.

Bulding:

* git clone git@github.com:commodo/s-lede.git
* make target/ppce6500/t4240_64b V=99 -jN  [ where N number of jobs ]

Results will be in `s-lede/build/ppce6500/t4240_64b/bin/targets/ppce6500/t4240_64b-glibc`

The files of interest are:
* lede-ppce6500-t4240_64b-initramfs-zImage
* lede-ppce6500-t4240_64b-t4240rdb.fdt

Move these files to a TFTP server. Boot the T4, enter bootloader, and run these commands: 
* setenv ipaddr 192.168.100.9
* setenv serverip 192.168.100.8
* setenv bootargs 'rw console=ttyS0,115200'
* tftp 0x1000000 lede-ppce6500-t4240_64b-initramfs-zImage
* tftp 0x2000000 lede-ppce6500-t4240_64b-t4240rdb.fdt
* bootm 0x1000000 - 0x2000000
