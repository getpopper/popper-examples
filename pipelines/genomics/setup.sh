#!/usr/bin/env bash

# Moves to the docker directory.
cd docker

# Makes sure
docker stop genomic_container
docker rm genomic_container

# build genomics container.
docker build -t genomics .

docker run -it --name=genomic_container genomics

docker exec genomic_container ./docker-setup.sh