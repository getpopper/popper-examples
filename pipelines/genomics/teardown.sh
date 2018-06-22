#!/usr/bin/env bash

# Copy results from container to local
docker cp genomic_container:/app/dc_workshop/results/ output

docker stop genomic_container

docker rm genomic_container