# fixed-ir.lv2

A lv2 plugin template with associated build files to create an LV2 convolution plugin that ships with a fixed set of IRs. This is limited to mono files at the moment, since the author only needs it to ship cab IRs in a plugin host that doesn't support loading responses from files yet.

# Requirements

* g++, gnu make, lv2, libsndfile, libsamplerate, lilv

# Generating plugin source

First we need to compile the helper program that converts a .wav file to a C-source:

```
make
```

Then to create plugin source code from a number of wavefiles run

```
./wavs2plugin.sh [name] [IR1] [IR2] .... [IRN]
```

# Building the plugin

run

```
make -C fixed-ir-[name]
```

where `[name]` is the name you have chosen in the previous step.


