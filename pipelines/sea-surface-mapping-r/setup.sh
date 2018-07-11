#!/usr/bin/env bash

set -e

cd docker

mkdir docker/scripts/data

wget -P scripts/data/ "https://daac.ornl.gov/daacdata/global_vegetation/GIMMS3g_NDVI_Trends/data/gimms3g_ndvi_1982-2012.nc4"

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