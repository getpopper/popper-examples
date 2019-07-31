#!/usr/bin/env bash
set -e

pushd workflows/spparks/demo/visualization
$spk < viz.spkin


python pizza_dump2vtk.py potts.dump