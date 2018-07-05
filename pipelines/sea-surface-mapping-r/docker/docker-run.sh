#!/usr/bin/env bash

python --version

pip install -U scipy
pip install -U numpy

# All required libraries required for your project.
Rscript scripts/install_libraries_after_packrat.R

Rscript scripts/generate_map.r