#!/bin/bash

find "$2" -iname '*.wav' -exec bash wavs2plugin.sh "$1" {} \+
