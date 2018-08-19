#!/usr/bin/env bash
# [wf] execute setup stage

# Checks if a virtual environment is active.
if [ "$VIRTUAL_ENV" != "" ]; then
    source "$VIRTUAL_ENV"/bin/activate
    echo "It looks like you have an active virtual environment. I'll deactivate it in order to execute this pipeline."
    deactivate
fi

# Create virtual environment using python 2.7
virtualenv --python=python3.4 virtual-environment-python-36/

source virtual-environment-python-36/bin/activate

pip install pypet
pip install configparser
pip install brian2