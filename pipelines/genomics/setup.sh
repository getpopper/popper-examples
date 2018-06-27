#!/usr/bin/env bash

# Moves to the docker directory.
cd docker

# Makes sure
docker stop genomic_container
docker rm genomic_container

docker rmi genomics

# build genomics container.
docker build -t genomics .

docker create -it --name=genomic_container genomics

docker start genomic_container

docker exec  -it genomic_container ./docker-setup.sh