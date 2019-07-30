#!/usr/bin/env bash

pushd workflows/spparks/submodules/sppark-demo/demos/visualization
$spk < viz.spkin
python3 -m venv ./venv
source ./venv/bin/activate

pip3 install --no-cache-dir "numpy>=1.12.0"
dump 1.0 text potts.dump

python pizza_dump2vtk.py potts.dump