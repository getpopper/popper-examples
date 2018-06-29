#!/usr/bin/env bash

rm pipelines/secret.tar
cd secret
tar cvf ../pipelines/secret.tar .
cd -

cd pipelines
travis encrypt-file secret.tar --add

