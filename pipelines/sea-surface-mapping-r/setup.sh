#!/usr/bin/env bash

cd docker

# Makes sure
docker stop mapping_container
docker rm mapping_container

docker rmi mapping


docker build -t mapping .

docker create -it --name=mapping_container mapping

docker start mapping_container

docker exec  -it mapping_container ./docker-setup.sh