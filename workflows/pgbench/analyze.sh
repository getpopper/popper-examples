#!/usr/bin/env sh
set -ex

mkdir -p "$GITHUB_WORKSPACE/workflows/pgbench/figures"

docker run --rm -p 8888:8888 -v "$GITHUB_WORKSPACE":/experiment --workdir=/experiment --user=root --entrypoint=jupyter jupyter/scipy-notebook nbconvert --execute workflows/pgbench/analyze.ipynb --ExecutePreprocessor.timeout=-1 --inplace

