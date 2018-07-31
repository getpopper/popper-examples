#!/bin/bash
set -e -x
docker run --rm -p 8888:8888 -v `pwd`:/experiment --workdir=/experiment/results --user=root --entrypoint=jupyter octave-alpine:3.5 nbconvert --execute visualize.ipynb --ExecutePreprocessor.timeout=-1 --inplace
