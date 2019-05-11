#!/usr/bin/env sh
set -ex

mkdir -p "$GITHUB_WORKSPACE/workflows/pgbench/figures"

docker run --rm \
  --volume "$GITHUB_WORKSPACE/workflows/pgbench":/pgbench \
  --workdir=/pgbench \
  --user=root \
  --entrypoint=jupyter \
  jupyter/scipy-notebook:4d7dd95017ed nbconvert \
    --execute analyze.ipynb \
    --ExecutePreprocessor.timeout=-1 \
    --inplace
