#!/bin/bash

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
pip install numpy

# [wf] Check if PLOTY_USERNAME environment variable is set
if [ -z "$PLOTY_USERNAME" ]; then
  echo "ERROR: PLOTY_USERNAME environment variable needs to be set"
  exit 1
fi

# [wf] Check if PLOTY_API_KEY environment variable is set
if [ -z "$PLOTY_API_KEY" ]; then
  echo "ERROR: PLOTY_API_KEY environment variable needs to be set"
  exit 1
fi

# [wf] Make data folder

mkdir data

# [wf] script for generating data
Rscript scripts/generate_map.r
