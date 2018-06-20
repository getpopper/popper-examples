#!/usr/bin/env bash

# [wf] executes docker-setup stage

# Chance to the docker directory.
cd docker

# build genomics container.
docker build -t genomics .

# execute container
docker run --name=genomic_container genomics ./genomics.sh

# Copy results from container to local
docker cp genomic_container:/app/dc_workshop/results/ output

# Remove container
docker rm genomic_container

