LDFLAGS ?= -lsndfile
CFLAGS ?= -Wall -O3

PREFIX ?= /usr/local

all: fixed-ir-wav2c

install: fixed-ir-wav2c
	install -d ${PREFIX}/bin
	install fixed-ir-wav2c ${PREFIX}/bin
	install fixed-ir*.sh ${PREFIX}/bin
