#!/bin/bash
set -e

source variables.sh

yes y | ssh-keygen -t rsa -N "" -f credentials/id_rsa -C root


docker run -i -t --rm \
    -e TF_VAR_gce_ssh_user=$SSH_USER \
    -e TF_VAR_gce_ssh_pub_key_file=/credentials/$SSH_PUB_KEY_FILE \
    -e TF_VAR_gce_ssh_key_file=/credentials/$SSH_KEY_FILE \
    -e TF_VAR_gce_image=$GCE_IMAGE \
    -e TF_VAR_gce_machine_type=$GCE_MACHINE_TYPE \
    -e TF_VAR_gce_service_account=/credentials/$GCE_SERVICE_ACCOUNT \
    -v $PWD/terraform:/plan \
    -v $PWD/credentials:/credentials \
    --workdir=/plan \
    hashicorp/terraform:light \
    init -input=false

docker run -i -t --rm \
    -e TF_VAR_gce_ssh_user=$SSH_USER \
    -e TF_VAR_gce_ssh_pub_key_file=/credentials/$SSH_PUB_KEY_FILE \
    -e TF_VAR_gce_ssh_key_file=/credentials/$SSH_KEY_FILE \
    -e TF_VAR_gce_image=$GCE_IMAGE \
    -e TF_VAR_gce_machine_type=$GCE_MACHINE_TYPE \
    -e TF_VAR_gce_service_account=/credentials/$GCE_SERVICE_ACCOUNT \
    -v $PWD/terraform:/plan \
    -v $CREDENTIAL_DIR:/credentials \
    --workdir=/plan \
    hashicorp/terraform:light \
    plan -out=tfplan -input=false

docker run -i -t --rm \
    -e TF_VAR_gce_ssh_user=$SSH_USER \
    -e TF_VAR_gce_ssh_pub_key_file=/credentials/$SSH_PUB_KEY_FILE \
    -e TF_VAR_gce_ssh_key_file=/credentials/$SSH_KEY_FILE \
    -e TF_VAR_gce_image=$GCE_IMAGE \
    -e TF_VAR_gce_machine_type=$GCE_MACHINE_TYPE \
    -e TF_VAR_gce_service_account=/credentials/$GCE_SERVICE_ACCOUNT \
    -v $PWD/terraform:/plan \
    -v $CREDENTIAL_DIR:/credentials \
    --workdir=/plan \
    hashicorp/terraform:light \
    apply -input=false tfplan

docker run -i -t --rm \
    -v $PWD/terraform:/plan \
    -v $CREDENTIAL_DIR:/credentials \
    --workdir=/plan \
    hashicorp/terraform:light \
    output external_ip > baseliner/hosts

