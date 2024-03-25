#!/bin/bash

set -xeo pipefail

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
  fixed-ir-wav2c "$IR" "$index" >> "$out"/irs.c
done

echo "struct IR *IRs[] = {" >> $out/irs.c

for (( index=0; index<${number_of_irs};index++ )); do
  echo '  &'IR"$index", >> "$out"/irs.c
done

echo "};" >> "$out/irs.c"

echo "static unsigned n_IR = ${number_of_irs};" >> "$out/irs.c"

SCALE_POINTS="$(for (( index=0;index<${number_of_irs};index++ )); do IR="${IRS[$index]}"; echo -n "lv2:scalePoint [rdfs:label \"$(basename "$IR")\"; rdf:value $index]; "; done)"

echo SCALE_POINTS: $SCALE_POINTS

PLUGIN_DIR="$out"/"$out".lv2

mkdir -p "$PLUGIN_DIR"

cat makefile_template | sed -e "s/COLLECTION/$COLLECTION/g" | sed -e "s;PLUGIN_DIR;$out.lv2;g" > "$out"/makefile

cat manifest_template.ttl | sed -e "s/COLLECTION/$COLLECTION/g" > "$PLUGIN_DIR"/manifest.ttl

cat plugin_template.ttl | sed -e "s/SCALE_POINTS/$SCALE_POINTS/g" | sed -e "s/COLLECTION/$COLLECTION/g" | sed -e "s/NUMBER_OF_IRS/$number_of_irs/g" > "$PLUGIN_DIR"/plugin.ttl

cat plugin_template.cc | sed -e "s/COLLECTION/$COLLECTION/g" | sed -e "s/NUMBER_OF_IRS/$number_of_irs/g" > "$out"/plugin.cc

cp -rvf vendored "$out"/
