#!/bin/bash

ARGS=("$@")

COLLECTION="${ARGS[0]}"

echo Collection: "$COLLECTION"

out="fixed-ir-$COLLECTION"

mkdir -p "$out"

echo "struct IR { float sample_rate; unsigned n_samples; float *sample_data; };" > "$out"/irs.c

IRS=("${ARGS[@]:1}")

number_of_irs=${#IRS[@]}

for (( index=0; index<${number_of_irs};index++ )); do
  IR="${IRS[$index]}"
  echo IR: "$index": "$IR"
  ./wav2c "$IR" sample_data"$index" >> "$out"/irs.c
done

# echo IRs: "${IRS[@]}"
