#!/bin/bash
# [wf] obtain and clean dataset
set -ex

# check if virtualenv is running

 if [ "$VIRTUAL_ENV" != "" ]; then
    echo "You are in a working virtualenv $VIRTUAL_ENV";
    # Install required packages.
    pip install xarray
    pip install netCDF4
    pip install plotly
 else
    echo ERROR: virtualenv not found. Please make sure that virtualenv is installed and running.
    exit 1
fi
