# Makefile for example programs

TOPDIR=.
OUT=$(TOPDIR)/temp
SRC=$(TOPDIR)/examples
CC=gcc
PROGRAMS= $(OUT)/similar1 $(OUT)/similar2  $(OUT)/mipshello

# To build MIPS you need to add the OpenWRT buildroot bin to the PATH

MIPSCC=mips-openwrt-linux-gcc
MIPSSTRIP=mips-openwrt-linux-strip

all: forced_things $(PROGRAMS)

helpers: forced_things temp/

keep: forced_things $(PROGRAMS)
	cp -v temp/similar1 temp/similar2 temp/mipshello examples/

forced_things:
	@echo 'e cfg.fortunes=false' >> ~/.radare2rc

$(OUT)/similar1: $(SRC)/similarfile1.c | temp/
	$(CC) -Wall -g -O2 -DEXAMPLE1 $(SRC)/similarfile1.c -o $(OUT)/similar1 
	strip $(OUT)/similar1

$(OUT)/similar2: $(SRC)/similarfile1.c | temp/
	$(CC) -Wall -g -O2 -DEXAMPLE2 $(SRC)/similarfile1.c -o $(OUT)/similar2
	strip $(OUT)/similar2

$(OUT)/mipshello: $(SRC)/mipshello.c | temp/
	$(MIPSCC) -Wall -march=34kc -mtune=34kc -Os $(SRC)/mipshello.c -o $(OUT)/mipshello
	$(MIPSSTRIP) $(OUT)/mipshello

temp:
	mkdir -p temp

debug:
	@echo TOPDIR=$(TOPDIR)
	@echo OUT=$(OUT)
	@echo SRC=$(SRC)

clean:
	-rm -rf temp
	-find -name "*~" -delete

.PHONY: all keep forced_things debug clean
