# Порт Alley Cat (IBM PC, 1984) для БК-0010 + СМК-512: ядро + сцены в страницах ДОЗУ
VERSION=1.0
BUILD_DATE=$(shell date +%d.%m.%Y)
XGCC=/home/prcoder/xgcc
CFLAGS=-std=gnu23 -fomit-frame-pointer -msoft-float -nostartfiles -nodefaultlibs -nostdlib -m10 -Os -I$(XGCC)/include
ASFLAGS=-mno-fpu -mlimited-eis
CC=pdp11-aout-gcc
AS=pdp11-aout-as
LD=pdp11-aout-ld
OUT=bin

KERNEL_OBJ=crt0.o gfxc.o hw.o common.o helpers.o divmulmod.o memory.o font.o \
	cat.o dog.o snd.o score.o text.o ovl.o main.o inl.o
OVL_ALLEYBG=ovl_alleybg.o alley_bg.o wash.o data_alleybg.o data_wash.o
OVL_ALLEY=ovl_alley.o sndpoll.o rope.o alley.o alley_land.o wash.o data_alley.o data_wash.o

OVERLAYS=TITLE INTER ALLEYBG ALLEY ROOM1 ROOM2 ROOM3 ROOM4 ROOM5 ROOM6 ROOM7

all: $(OUT)/CAT.BIN $(OUT)/HI $(addprefix $(OUT)/,$(OVERLAYS)) $(OUT)/ALLEYCAT.IMG

DATA_H=data_kernel.h data_bonus.h data_inter.h data_title.h data_alley.h data_alleybg.h data_wash.h data_room.h data_room1.h data_room2.h data_room3.h data_room4.h data_room5.h data_room6.h data_room7.h

%.o: %.c $(DATA_H)
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# версия и дата сборки — на экране загрузки (ovl.c); version.h переписывается,
# только если строка изменилась
version.h: FORCE
	@echo '#define VERSION_STR "VERSION $(VERSION) ($(BUILD_DATE))"' > version.h.tmp
	@cmp -s version.h.tmp version.h && rm version.h.tmp || mv version.h.tmp version.h
ovl.o: version.h
FORCE:

data_%.c data_%.h: re/data_%.py re/mkdata.py
	cd re && python3 mkdata.py $*


# блиттер и константы ядра: копия в каждой странице СМК с 0144000
HI_OBJ=gfx.o gfxtab.o data_kernel.o
HI.out: $(HI_OBJ) hi.ld
	$(LD) -T hi.ld -Map HI.map -o $@ $(HI_OBJ)
	@python3 mkbin.py --check $@ 0o144000 0o160000

kernel.out: $(KERNEL_OBJ) kernel.ld HI.out
	$(LD) -T kernel.ld -R HI.out -Map kernel.map -o $@ $(KERNEL_OBJ)
	@python3 mkbin.py --check $@ 0o1000 0o37000

$(OUT):
	mkdir -p $(OUT)

$(OUT)/CAT.BIN: kernel.out | $(OUT)
	python3 mkbin.py $< $@

$(OUT)/HI: HI.out | $(OUT)
	python3 mkbin.py $< $@ 0o144000

# сцена: окно СМК с 0120000 до блока HI
OVL_BASE=0o120000

define overlay
$(1).out: ovlhdr.o $(2) kernel.out ovl.ld
	$(LD) -T ovl.ld --defsym=OVL=0120000 -R kernel.out -R HI.out -Map $(1).map -o $$@ ovlhdr.o $(2)
	@python3 mkbin.py --check $$@ 0o120000 0o144000
$(OUT)/$(1): $(1).out | $(OUT)
	python3 mkbin.py $$< $$@ $$(OVL_BASE)
endef


$(eval $(call overlay,TITLE,ovl_title.o gfxcrop.o alley_bg.o alley_land.o wash.o data_title.o data_alleybg.o data_alley.o data_wash.o))
$(eval $(call overlay,INTER,ovl_inter.o bonus.o data_inter.o data_bonus.o))
$(eval $(call overlay,ALLEYBG,$(OVL_ALLEYBG)))
$(eval $(call overlay,ALLEY,$(OVL_ALLEY)))
$(foreach r,1 3 4 5 6,$(eval $(call overlay,ROOM$(r),ovl_room$(r).o sndpoll.o room.o data_room.o data_room$(r).o)))
$(eval $(call overlay,ROOM2,ovl_room2.o sndpoll.o data_room2.o))
$(eval $(call overlay,ROOM7,ovl_room7.o fwin.o bonus.o data_room7.o data_bonus.o))

# дискета ANDOS с игрой: чистый ANDOS.IMG + ядро (с автостартом), HI и сцены
GAME_FILES=$(OUT)/CAT.BIN $(OUT)/HI $(addprefix $(OUT)/,$(OVERLAYS))
$(OUT)/ALLEYCAT.IMG: ANDOS.IMG mkandos.py $(GAME_FILES) | $(OUT)
	python3 mkandos.py ANDOS.IMG $@ +$(GAME_FILES)

andos: $(OUT)/ALLEYCAT.IMG

sizes: all
	@pdp11-aout-size kernel.out HI.out $(addsuffix .out,$(OVERLAYS))

asm-files:
	for f in *.c; do $(CC) $(CFLAGS) -S -fverbose-asm $$f; done

clean:
	rm -f *.o *.out *.map version.h $(OUT)/*

.PHONY: all clean asm-files sizes andos FORCE
.SECONDARY:
