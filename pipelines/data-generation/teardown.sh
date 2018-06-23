#!/bin/bash
set -e

docker pull ivotron/geni-lib:v0.9.6.0 &> /dev/null

if [ -z $CLOUDLAB_USER ]; then
  echo "Expecting CLOUDLAB_USER variable"
  exit 1
fi

if [ -z $CLOUDLAB_PASSWORD ]; then
  echo "Expecting CLOUDLAB_PASSWORD variable"
  exit 1
fi

if [ -z $CLOUDLAB_PROJECT ]; then
  echo "Expecting CLOUDLAB_PROJECT variable"
  exit 1
fi

if [ -z $CLOUDLAB_PUBKEY_PATH ]; then
  echo "Expecting CLOUDLAB_PUBKEY_PATH variable"
  echo "Looking in the travis secret folder"
  if [ -d "travis-secrets/id_rsa.pub" ]; then
    echo "Couldn't find id_rsa.pub"
    exit 1
  fi
  echo "Found! Configuring everything for you"
  export CLOUDLAB_PUBKEY_PATH="`pwd`/travis-secrets/id_rsa.pub"
fi

if [ -z $CLOUDLAB_CERT_PATH ]; then
  echo "Expecting CLOUDLAB_CERT_PATH variable"
  echo "Looking in the travis secret folder"
  if [ -d "travis-secrets/cloudlab.pem" ]; then
    echo "Couldn't find cloudlab.pem"
    exit 1
  fi
  echo "Found! Configuring everything for you"
  export CLOUDLAB_CERT_PATH="`pwd`/travis-secrets/cloudlab.pem"
fi

docker run --rm --name=geni-lib \
  -e CLOUDLAB_USER=$CLOUDLAB_USER \
  -e CLOUDLAB_PASSWORD=$CLOUDLAB_PASSWORD \
  -e CLOUDLAB_PROJECT=$CLOUDLAB_PROJECT \
  -e CLOUDLAB_PUBKEY_PATH=$CLOUDLAB_PUBKEY_PATH \
  -e CLOUDLAB_CERT_PATH=$CLOUDLAB_CERT_PATH \
  -v $CLOUDLAB_PUBKEY_PATH:$CLOUDLAB_PUBKEY_PATH \
  -v $CLOUDLAB_CERT_PATH:$CLOUDLAB_CERT_PATH \
  -v `pwd`/geni/release.py:/release.py \
  -v `pwd`/vars.yml:/vars.yml \
  --entrypoint=python \
  ivotron/geni-lib:v0.9.6.0 -u /release.py
