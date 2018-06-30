#!/usr/bin/env bash

# Checks if a virtual environment is active.
if [ "$VIRTUAL_ENV" != "" ]; then
    source "$VIRTUAL_ENV"/bin/activate
    echo "It looks like you have an active virtual environment. I'll deactivate it in order to execute this pipeline."
    deactivate
fi

# Create virtual environment using python 2.7
virtualenv --python=python2.7 virtual-environment-python-27/

source virtual-environment-python-27/bin/activate

pip install scipy