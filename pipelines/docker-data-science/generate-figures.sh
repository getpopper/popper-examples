#!/usr/bin/env bash
# [wf] execute generate-figures.sh stage

docker run -v `pwd`/results:/app/results dspython python generate_figures.py
