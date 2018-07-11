#!/usr/bin/env bash

# Required libraries for your script. (These libraries will be installed inside of a packrat folder.)
Rscript scripts/install_libraries.R

# Executes your script.
Rscript scripts/generate_map.r
