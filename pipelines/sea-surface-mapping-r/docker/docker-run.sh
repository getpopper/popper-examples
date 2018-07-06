#!/usr/bin/env bash

python --version

pip install -U scipy
pip install -U numpy

Rscript scripts/packrat_requirements.R

Rscript scripts/generate_map.r