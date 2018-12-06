#!/usr/bin/env bash
# [wf] create charts
set -ex

# [wf] read parameters of pipeline
source scripts/yaml.sh
read_yaml parameters.yml

if [ "$use_singularity" == "true" ]; then
  echo "Not supported yet"
  exit 1
fi

docker run --rm \
  -v $PWD:/pipe \
  --workdir /pipe \
  local/pypet-brian2 \
    python scripts/plot_results.py hdf5/example_23.hdf5
