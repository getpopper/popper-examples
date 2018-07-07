#!/bin/bash
set -e

CREDENTIAL_DIR=$PWD/credentials
SSH_USER=popper
SSH_PUB_KEY_FILE=id_rsa.pub
SSH_KEY_FILE=id_rsa
GCE_IMAGE=debian-9
GCE_MAGINE_TYPE=${GCE_MACHINE_TYPE:-g1-small}
GCE_SERVICE_ACCOUNT=account.json

