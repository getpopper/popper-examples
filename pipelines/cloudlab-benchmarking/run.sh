#!/bin/bash
set -ex

if [ -z $SSHKEY ]; then
  echo "Expecting SSHKEY variable"
  echo "Looking in the travis secret folder"
  if [ ! -f "geni/id_rsa" ]; then
    echo "Couldn't find id_rsa"
    exit 1
  fi
  echo "Found! Configuring everything for you"
  export SSHKEY="`pwd`/geni/id_rsa"
fi

# delete previous results
rm -fr results/baseliner_output
mkdir -p results/baseliner_output

docker pull ivotron/baseliner:0.2

docker run --rm --name=baseliner \
  --volume `pwd`:/experiment \
  --volume $SSHKEY:/root/.ssh/id_rsa \
  --workdir=/experiment/ \
  --net=host \
  ivotron/baseliner:0.2 \
    -i /experiment/geni/machines \
    -f /experiment/baseliner/config.yml \
    -o /experiment/results/baseliner_output
