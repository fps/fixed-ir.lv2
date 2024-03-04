name=$1
irs="${@:2}"

echo Name: "$name"
echo IRs: "$irs"

octave wav2c.m $irs > irs.cc
octave create.m $*


