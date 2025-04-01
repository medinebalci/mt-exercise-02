#! /bin/bash

scripts=$(dirname "$0")
base=$(cd "$scripts/.." && pwd)


models=$base/models
data=$base/data
tools=$base/tools
samples=$base/samples

mkdir -p $samples

num_threads=4
device=""

(cd $scripts/tools/pytorch-examples/word_language_model&&
    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python generate.py \
        --data $data/littlewomen \
        --words 100 \
        --checkpoint $models/model.pt \
        --outf $samples/sample
)