#!/usr/bin/env bash

# all R libraries required for packrat
Rscript scripts/install_libraries_before_packrat.R

Rscript scripts/init_packrat.R