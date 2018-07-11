#!/bin/bash
set -ex

mkdir -p inventory

INVENTORY_DIR=$PWD/baseliner

docker run --rm -it \
  -e OS_AUTH_URL=$OS_AUTH_URL\
  -e OS_TENANT_ID=$OS_TENANT_ID \
  -e OS_TENANT_NAME=$OS_TENANT_NAME \
  -e OS_USERNAME=$OS_USERNAME \
  -e OS_PASSWORD=$OS_PASSWORD \
  -e OS_REGION_NAME=$OS_REGION_NAME \
  -e OS_ENDPOINT_TYPE=$OS_ENDPOINT_TYPE \
  -e OS_IDENTITY_API_VERSION=2 \
  -v $PWD/scripts:/scripts \
  -v $INVENTORY_DIR:/enos \
  --workdir=/scripts \
  --entrypoint=python \
  trufas/enoslib request.py

sleep 5m

exit 0
