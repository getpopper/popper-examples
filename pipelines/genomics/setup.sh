#!/usr/bin/env bash

# Moves to the docker directory.
cd docker

# build genomics container.
docker build -t genomics .

docker run -t -d --name=genomic_container genomics

docker exec genomic_container ./docker-setup.sh