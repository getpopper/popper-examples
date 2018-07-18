#!/bin/bash
set -e -x
docker run --rm -p 8888:8888 -v "$PWD":/experiment --workdir=/experiment/results --user=root --entrypoint=jupyter smizy/octave:4.2.0-alpine nbconvert --execute visualize.ipynb --ExecutePreprocessor.timeout=-1 --inplace
