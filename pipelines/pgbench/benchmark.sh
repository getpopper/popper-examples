#!/usr/bin/env bash

PG_IMAGES=${PG_IMAGES:-$PG_VERSIONS}
echo $PG_IMAGES
rm $GITHUB_WORKSPACE/pipelines/pgbench/results_/*


mkdir -p $PWD/pipelines/pgbench/results_

for image in $(echo $PG_IMAGES | sed "s/,/ /g")
do
  docker run --name pg$image -e POSTGRES_PASSWORD=pgbench -d postgres:$image
  docker exec pg$image pg_isready -t 20

  for query_mode in simple extended prepared
  do
    for n_threads in 1 2 4 8 16 32
    do
      echo "Running pgbench for image $image with $n_threads threads and $query_mode query mode."
      echo pgbench | docker run -i --rm --link pg$image:postgres postgres:$image pgbench -i -h postgres -U postgres
      echo pgbench | docker run -i --rm --link pg$image:postgres postgres:$image pgbench -h postgres -U postgres -M $query_mode -t $n_threads > $PWD/pipelines/pgbench/results_/$image-$n_threads-$query_mode.results
    done
  done
  echo "Killing container for postgres $image"
  docker kill pg$image
  echo "Removing container for postgres $image"
  docker rm pg$image
done
