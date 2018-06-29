#!/usr/bin/env bash

rm pipelines/secret.tar
cd secret
tar cvf ../pipelines/secret.tar .
cd -

travis encrypt-file pipelines/secret.tar -w pipelines/secret.tar --add


