#!/usr/bin/env bash

set -e

cd docker

mkdir scripts/data

wget -P scripts/data/ "https://www.dropbox.com/s/c9n47ttqalwadfd/gimms3g_ndvi_1982-2012.nc4?dl=0"


# Makes sure
# docker stop mapping_container
# docker rm mapping_container

# docker rmi mapping

# docker build -t mapping .

docker build -t mapping .

# docker create -it --name=mapping_container mapping

# docker start mapping_container

# docker exec -it mapping_container ./docker-setup.sh

docker run mapping ./docker-setup.sh