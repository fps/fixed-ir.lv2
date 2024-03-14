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
  ./wav2c "$IR" "$index" >> "$out"/irs.c
done

echo "struct IR *IRs[] = {" >> $out/irs.c

for (( index=0; index<${number_of_irs};index++ )); do
  echo '  &'IR"$index", >> "$out"/irs.c
done

echo "};" >> "$out/irs.c"

# echo IRs: "${IRS[@]}"
