LDFLAGS ?= -lsndfile
CFLAGS ?= -Wall -O3

PREFIX ?= /usr/local

all: wav2c

install: wav2c
  install -d ${PREFIX}/bin
  install wav2c ${PREFIX}/bin
  install fixed-ir*.sh ${PREFIX}/bin
