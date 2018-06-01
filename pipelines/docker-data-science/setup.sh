#!/usr/bin/env bash
# [wf] execute setup.sh stage

if ! type "docker" > /dev/null; then
  exit 1
fi

docker build docker -t dspython

