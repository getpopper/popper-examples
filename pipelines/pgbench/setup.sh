#!/usr/bin/env bash
# [wf] execute setup stage

PG_IMAGES=${PG_IMAGES:-9.6,9.3}

mkdir -p results

for image in $(echo $PG_IMAGES | sed "s/,/ /g")
do
  docker run --name pg$image -e POSTGRES_PASSWORD=pgbench -d postgres:$image 
done

