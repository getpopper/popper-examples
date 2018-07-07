#!/bin/bash
set -ex

source variables.sh

# delete previous results
rm -rf results/baseliner_output
mkdir -p results/baseliner_output

docker pull ivotron/baseliner:0.2

docker run --rm --name=baseliner \
  --volume `pwd`:/experiment \
  --volume $CREDENTIAL_DIR/$SSH_KEY_FILE:/root/.ssh/id_rsa \
  --workdir=/experiment/ \
  --net=host \
  ivotron/baseliner:0.2 \
    -i /experiment/baseliner/hosts \
    -f /experiment/baseliner/config.yml \
    -o /experiment/results/baseliner_output
