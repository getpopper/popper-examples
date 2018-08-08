#!/usr/bin/env bash
# [wf] execute setup stage

if [ "$VIRTUAL_ENV" != "" ]; then
    source "$VIRTUAL_ENV"/bin/activate
    echo "It looks like you have an active virtual environment. I'll deactivate it in order to execute this pipeline."
    deactivate
fi

echo "Starting setup"

# Create virtual environment using python 3.4
virtualenv --python=python3.4 virtual-environment-python-34/

echo "activating virtual environment"

source virtual-environment-python-34/bin/activate

pip3 install --upgrade pip

echo "installing dependencies with pip"

pip3 install vpython

echo "done"