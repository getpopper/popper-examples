#!/usr/bin/env bash
# [wf] execute setup stage
set -e

mkdir -p figures

docker run --rm -p 8888:8888 -v "$PWD":/home/jovyan --entrypoint=jupyter jupyter/scipy-notebook nbconvert --execute analyze.ipynb --ExecutePreprocessor.timeout=-1 --inplace



