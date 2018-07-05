#!/usr/bin/env bash

# Makes sure
mkdir output

docker cp mapping_container:/app/ output/

docker stop mapping_container
docker rm mapping_container