LDFLAGS ?= -lsndfile
CFLAGS ?= -Wall -O3

PREFIX ?= /usr/local

all: fixed-ir-wav2c

install: fixed-ir-wav2c
	install -d ${PREFIX}/bin
	install fixed-ir-wav2c ${PREFIX}/bin/
	install fixed-ir*.sh ${PREFIX}/bin/
	install -d ${PREFIX}/lib/fixed-ir.lv2
	install *template* ${PREFIX}/lib/fixed-ir.lv2/
	cp -r vendored ${PREFIX}/lib/fixed-ir.lv2/
