name=$1
irs="${@:2}"

echo Name: "$name"
echo IRs: "$irs"
echo Number of IRs: "${#irs[*]}"

octave wav2c.m $irs > irs.cc
octave create.m $*


