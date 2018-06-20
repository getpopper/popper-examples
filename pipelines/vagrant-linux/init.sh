#!/bin/bash

if ! type "docker" > /dev/null; then
  echo Docker not detected
  exit 1
fi

if ! type "vagrant" > /dev/null; then
  echo Docker not detected
  exit 1
fi
