#!/bin/bash
set -ex

INVENTORY_DIR=$PWD/baseliner

EXPERIMENT_TIMESTAMP=`cat /tmp/popper-exp-ts`

docker run --rm -it \
  -e OS_AUTH_URL=$OS_AUTH_URL\
  -e OS_TENANT_ID=$OS_TENANT_ID \
  -e OS_TENANT_NAME=$OS_TENANT_NAME \
  -e OS_USERNAME=$OS_USERNAME \
  -e OS_PASSWORD=$OS_PASSWORD \
  -e OS_REGION_NAME=$OS_REGION_NAME \
  -e OS_ENDPOINT_TYPE=$OS_ENDPOINT_TYPE \
  -e OS_IDENTITY_API_VERSION=$OS_IDENTITY_API_VERSION \
  -e EXPERIMENT_TIMESTAMP=$EXPERIMENT_TIMESTAMP \
  -v $PWD/scripts:/scripts \
  -v $INVENTORY_DIR:/enos \
  --workdir=/scripts \
  --entrypoint=python \
  trufas/blazar release.py

exit 0

