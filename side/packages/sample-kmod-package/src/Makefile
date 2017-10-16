obj-m := sample_kmod_app.o

sample_kmod_app-y := main.o
ccflags-y := -g

ifndef ${LINUX_DIR}
	MODULES_DIR := /lib/modules/$(shell uname -r)
	LINUX_DIR := ${MODULES_DIR}/build
endif

modules:
	make -C ${LINUX_DIR} M=$$PWD $@;

clean:
	make -C ${LINUX_DIR} M=$$PWD $@;

load:
	insmod ./sample_kmod_app.ko

unload:
	rmmod sample_kmod_app
