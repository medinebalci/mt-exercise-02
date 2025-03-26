#! /bin/bash

# Convert Windows-style paths to Bash-compatible paths
scripts=$(dirname "$0")
base=$(realpath "$scripts/..")  # Ensure correct base path

data="$base/data"
tools="$base/tools"

mkdir -p "$data"

# Link default training data for easier access
mkdir -p "$data/wicked"


# Preprocess Wicked
mkdir -p "$data/wicked/raw"

if [[ -f "$data/wicked/raw/wicked.txt" ]]; then
    cat "$data/wicked/raw/wicked.txt" | python "$base/scripts/preprocess_raw.py" > "$data/wicked/raw/wicked.cleaned.txt"

    # Tokenize and preprocess
    cat "$data/wicked/raw/wicked.cleaned.txt" | python "$base/scripts/preprocess.py" --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > "$data/littlewomen/raw/littlewomen.preprocessed.txt"

    # Split into train, valid, and test
    head -n 440 "$data/wicked/raw/wicked.preprocessed.txt" | tail -n 400 > "$data/wicked/valid.txt"
    head -n 840 "$data/wicked/raw/wicked.preprocessed.txt" | tail -n 400 > "$data/wicked/test.txt"
    tail -n 3075 "$data/wicked/raw/wicked.preprocessed.txt" | head -n 2955 > "$data/wicked/train.txt"
else
    echo "Error: The file wicked.txt does not exist in $data/wicked/raw/"
fi
