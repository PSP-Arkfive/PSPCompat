TARGET = pspcompat

C_OBJS = \
	main.o \
	src/syspatch.o \
	src/wpa2.o  \
	src/cwpatch.o \
	src/high_mem.o  \
	src/libertas.o   \
	src/usb_charge.o  \
	src/region_free.o \
	src/pops4tool.o
		
OBJS = \
	$(C_OBJS) imports.o

all: $(TARGET).prx

INCDIR = include external/include
CFLAGS = -std=c99 -Os -G0 -Wall -fno-pic

CFLAGS += -I include -I $(ARKROOT)/common/include/ -I $(ARKROOT)/libs/graphics/ -I $(ARKROOT)/core/systemctrl/include/

CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS = $(CFLAGS)

BUILD_PRX = 1
PRX_EXPORTS = exports.exp

USE_KERNEL_LIBC=1
USE_KERNEL_LIBS=1

LIBDIR = $(ARKROOT)/libs
LDFLAGS =  -nostartfiles
LIBS = -lpspsystemctrl_kernel

PSP_FW_VERSION = 660

PSPSDK=$(shell psp-config --pspsdk-path)
include $(PSPSDK)/lib/build.mak
