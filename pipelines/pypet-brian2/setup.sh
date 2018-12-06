#!/usr/bin/env bash
# [wf] create container
set -e

# [wf] read parameters of pipeline
source scripts/yaml.sh
read_yaml parameters.yml

set -x

# [wf] build the container
docker build -t local/pypet-brian2 docker

if [ "$use_singularity" != "true" ]; then
  # no singularity requested; we're done
  exit 0
fi

# [wf] build singularity image
docker run -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/test:/output \
  --privileged -t --rm \
  singularityware/docker2singularity:v2.5 \
    local/pypet-brian2
