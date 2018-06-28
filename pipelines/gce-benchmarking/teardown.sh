#!/bin/bash
set -e

source variables.sh

docker run -i -t --rm \
    -e TF_VAR_gce_ssh_user=/credentials/$SSH_USER \
    -e TF_VAR_gce_ssh_pub_key_file=/credentials/$SSH_PUB_KEY_FILE \
    -e TF_VAR_gce_ssh_key_file=/credentials/$SSH_KEY_FILE \
    -e TF_VAR_gce_image=$GCE_IMAGE \
    -e TF_VAR_gce_service_account=/credentials/$GCE_SERVICE_ACCOUNT \
    -v $PWD/terraform:/plan \
    -v $CREDENTIAL_DIR:/credentials \
    --workdir=/plan \
    hashicorp/terraform:light \
    destroy -input=false -auto-approve


