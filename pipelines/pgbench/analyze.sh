#!/usr/bin/env bash
# [wf] execute setup stage
set -e

mkdir -p figures

docker run --rm -p 8888:8888 -v "$PWD":/experiment --workdir=/experiment --user=root --entrypoint=jupyter jupyter/scipy-notebook nbconvert --execute "$GITHUB_WORKSPACE/pipelines/pgbench/analyze.ipynb" --ExecutePreprocessor.timeout=-1 --inplace

