#!/usr/bin/env bash

# [wf] execute setup stage

set -e

cd docker

mkdir scripts/data

# Gets the data
wget -O scripts/data/gimms3g_ndvi_1982-2012.nc4 "https://www.dropbox.com/s/c9n47ttqalwadfd/gimms3g_ndvi_1982-2012.nc4?dl=0"

# build the container
docker build -t mapping .

# Start the container
docker run mapping ./docker-setup.sh
