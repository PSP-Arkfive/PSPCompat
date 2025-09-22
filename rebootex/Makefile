PSPSDK = $(shell psp-config --pspsdk-path)
ARKSDK ?= ../../ark-dev-sdk
REBOOTEXDIR ?= ../../BootLoadEx
TARGET = reboot.bin.gz

PYTHON=$(shell which python3)

all: $(TARGET)

INCDIR = $(PSPSDK)/include $(REBOOTEXDIR) $(ARKSDK)/include

CFLAGS = -std=c99 -Wall -Os -G0 -fno-pic $(addprefix -I, $(INCDIR)) -DREBOOTEX

CC = psp-gcc
LD = psp-ld
STRIP = psp-strip
OBJCOPY = psp-objcopy
LINKFILE = $(REBOOTEXDIR)/linkfile.l

REBOOT_OBJS = \
	main.o \
	lib.o \
	pspbtcnf.o \
	scanner.o

C_OBJS = \
	$(REBOOTEXDIR)/psp_rebootex/patches.o \

LIBS =

ifdef DEBUG
CFLAGS += -DDEBUG=$(DEBUG)
LIBS += -lcolordebugger
endif

crt0.o : $(REBOOTEXDIR)/crt0.S
	$(CC) -I$(PSPSDK)/include -c $< -o crt0.o

$(REBOOT_OBJS) : %.o : $(REBOOTEXDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

main.elf: crt0.o $(C_OBJS) $(REBOOT_OBJS)

$(TARGET): main.elf
	$(Q)$(STRIP) -s $<
	$(Q)$(OBJCOPY) -O binary $< $(patsubst %.gz,%,$(TARGET))
	$(Q)$(PYTHON) $(REBOOTEXDIR)/gz.py $(patsubst %.gz,%,$(TARGET)) $@
	$(Q)bin2c $@ payload.h rebootbuffer_psp
	@echo GET $@

clean:
	$(Q)rm -rf *~ *.s *.o *.elf reboot.bin reboot.bin.gz payload.h $(EXTRA_CLEAN)

include $(REBOOTEXDIR)/beauty_bin.mak
