#!/usr/bin/env bash
# [wf] execute run stage

echo "activating virtual environment"

source virtual-environment-python-36/bin/activate

echo "executing python script base_solution..."

python py-scripts/base_solution.py

echo "done"