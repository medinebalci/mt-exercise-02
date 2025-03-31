#! /bin/bash

# Convert Windows-style paths to Bash-compatible paths
scripts=$(dirname "$0")
base=$(realpath "$scripts/..")  # Ensure correct base path

data="$base/data"
tools="$base/tools"

mkdir -p "$data"

# Link default training data for easier access
mkdir -p "$data/littlewomen"


# Preprocess Little Women
mkdir -p "$data/littlewomen/raw"

if [[ -f "$data/littlewomen/raw/littlewomen.txt" ]]; then
    cat "$data/littlewomen/raw/littlewomen.txt" | python "$base/scripts/preprocess_raw.py" > "$data/littlewomen/raw/littlewomen.cleaned.txt"

    # Tokenize and preprocess
    cat "$data/littlewomen/raw/littlewomen.cleaned.txt" | python "$base/scripts/preprocess.py" --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > "$data/littlewomen/raw/littlewomen.preprocessed.txt"

    # Split into train, valid, and test
    head -n 440 "$data/littlewomen/raw/littlewomen.preprocessed.txt" | tail -n 400 > "$data/littlewomen/valid.txt"
    head -n 840 "$data/littlewomen/raw/littlewomen.preprocessed.txt" | tail -n 400 > "$data/littlewomen/test.txt"
    tail -n 3075 "$data/littlewomen/raw/littlewomen.preprocessed.txt" | head -n 2955 > "$data/littlewomen/train.txt"
else
    echo "Error: The file littlewomen.txt does not exist in $data/littlewomen/raw/"
fi
