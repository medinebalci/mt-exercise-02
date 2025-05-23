# MT Exercise 2: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/marpng/mt-exercise-02
    cd mt-exercise-02

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:
There is a littlewomen.txt in ./data/littlewomen/raw since I had to manually download it.

    ./scripts/download_data.sh

Train a model:
Changed the folder name to littlewomen

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

I ran training manually with the main.py since train.sh didn't work on my Windows laptop. I used the flags to denote the dropouts. 

Added a --logfile argument in main.py so you can save the training data in perplexity_log.

Modified the main.py to calculate perplexities at each epoch and compare/save the best and worst models. 

Plot models of training, test and validation perplexities with:

    python ./scripts/tools/pytorch-examples/word_language_model/plot_perplexity.py

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

I wasn't able to generate samples from worst_model.pt and best_model.pt.

