#!/usr/bin/env bash
# [wf] run simulation
set -e

# [wf] read parameters of pipeline
source scripts/yaml.sh
read_yaml parameters.yml

set -x

# [wf] remove previous results
rm -rf hdf5/ logs/

if [ "$use_singularity" == "true" ]; then
  echo "Not supported yet"
  exit 1
fi

docker run --rm \
  -v $PWD:/pipe \
  --workdir /pipe \
  local/pypet-brian2 \
    python scripts/example_23_brian2_network.py
