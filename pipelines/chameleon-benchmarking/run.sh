#!/bin/bash
set -ex

# delete previous results
rm -rf results/baseliner_output
mkdir -p results/baseliner_output

docker pull ivotron/baseliner:0.2

docker run --rm --name=baseliner \
  --volume `pwd`:/experiment \
  --volume $PWD/credentials/popper-key.pem:/root/.ssh/id_rsa \
  --workdir=/experiment/ \
  --net=host \
  ivotron/baseliner:0.2 \
    -i /experiment/baseliner/hosts \
    -f /experiment/baseliner/config.yml \
    -o /experiment/results/baseliner_output

exit 0

