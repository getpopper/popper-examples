#!/usr/bin/env bash

pushd workflows/spparks/submodules/sppark-demo/demos/visualization
$spk < viz.spkin

dump 1.0 text potts.dump

python pizza_dump2vtk.py potts.dump