#!/usr/bin/env bash
set -ex

echo "$PG_IMAGES"
rm "$GITHUB_WORKSPACE/pipelines/pgbench/results_/*"


mkdir -p "$GITHUB_WORKSPACE/pipelines/pgbench/results_"

for image in ${PG_IMAGES//,/ }
do
  docker run --name "$image" -e POSTGRES_PASSWORD=pgbench -d "postgres:${image: -3}"
  docker exec "$image" pg_isready -t 20

  for query_mode in simple extended prepared
  do
    for n_threads in 1 2 4 8 16 32
    do
      echo "Running pgbench for image $image with $n_threads threads and $query_mode query mode."
      echo pgbench | docker run -i --rm --link "$image":postgres "postgres:${image: -3}" pgbench -i -h postgres -U postgres
      echo pgbench | docker run -i --rm --link "$image":postgres "postgres:${image: -3}" pgbench -h postgres -U postgres -M "$query_mode" -t "$n_threads" > "$GITHUB_WORKSPACE/pipelines/pgbench/results_/$image-$n_threads-$query_mode.results"
    done
  done
done
