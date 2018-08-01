#!/usr/bin/env bash
# [wf] execute setup stage

# Checks if a virtual environment is active.
if [ "$VIRTUAL_ENV" != "" ]; then
    source "$VIRTUAL_ENV"/bin/activate
    echo "It looks like you have an active virtual environment. I'll deactivate it in order to execute this pipeline."
    deactivate
fi

# Create virtual environment using python 3
virtualenv --python=python3 virtual-environment-python-36/

source virtual-environment-python-36/bin/activate

pip3 install --upgrade pip wheel
pip3 install vpython