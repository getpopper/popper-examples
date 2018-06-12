#!/usr/bin/env bash

PG_IMAGES=${PG_IMAGES:-9.6,9.3}

for image in $(echo $PG_IMAGES | sed "s/,/ /g")
do
  echo "Killing container for postgres $image"
  docker kill pg$image
  echo "Removing container for postgres $image"
  docker rm pg$image
done
