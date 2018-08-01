#!/usr/bin/env bash
# [wf] execute setup stage

if [ "$VIRTUAL_ENV" != "" ]; then
    source "$VIRTUAL_ENV"/bin/activate
    echo "It looks like you have an active virtual environment. I'll deactivate it in order to execute this pipeline."
    deactivate
fi

echo "4"

# Create virtual environment using python 2.7
# virtualenv --python=python3.6 virtual-environment-python-36/

echo "3"

source virtual-environment-python-36/bin/activate

pip3 install --upgrade pip

echo "2"

pip3 install vpython

echo "1"