#!/bin/bash
# [wf] obtain and clean dataset
set -ex

# Create data folder
mkdir -p data

# Download required data from https://moderndata.plot.ly/weather-maps-in-python-with-mapbox-gl-xarray-and-netcdf4/
curl -L -o data/sst.day.anom.2017.v2.nc \
  ftp://ftp.cdc.noaa.gov/Datasets/noaa.oisst.v2.highres/sst.day.anom.2017.v2.nc

