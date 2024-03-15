#!/bin/bash

find "$2" -iname '*.wav' -exec bash fixed-ir-wavs2plugin.sh "$1" {} \+
