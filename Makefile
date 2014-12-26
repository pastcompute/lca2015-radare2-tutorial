# Makefile for example programs

TOPDIR=$(PWD)
OUT=$(TOPDIR)/temp
SRC=$(TOPDIR)/supportfiles
CC=gcc
PROGRAMS= $(OUT)/similar1 $(OUT)/similar2

all: $(PROGRAMS)

$(OUT)/similar1: $(SRC)/similarfile1.c | temp/
	$(CC) -Wall -g -O2 -DEXAMPLE1 $(SRC)/similarfile1.c -o $(OUT)/similar1 
	strip $(OUT)/similar1

$(OUT)/similar2: $(SRC)/similarfile1.c | temp/
	$(CC) -Wall -g -O2 -DEXAMPLE2 $(SRC)/similarfile1.c -o $(OUT)/similar2
	strip $(OUT)/similar2

temp:
	mkdir -p temp

clean:
	-rm -rf temp
	-find -name "*~" -delete