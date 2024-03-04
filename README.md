# fixed-ir.lv2

A lv2 plugin template with associated build files to create an LV2 convolution plugin that ships with a fixed set of IRs.

# Requirements

* For generating the plugin source code from a number of wavefiles: GNU Octave and basically coreutils
* For compiling the generated source: g++, gnu make, lv2

# Generating plugin source

Run

```
./create.sh [name] [IR1] [IR2] .... [IRN]
```

# Building the plugin

run

```
make
```

