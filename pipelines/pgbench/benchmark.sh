#!/usr/bin/env sh
set -ex

echo "$PG_IMAGES"
rm -rf "$GITHUB_WORKSPACE/pipelines/pgbench/results_/"


mkdir -p "$GITHUB_WORKSPACE/pipelines/pgbench/results_"

for image in $(echo "$PG_IMAGES" | sed "s/,/ /g")
do
  docker run --name "$image" -e POSTGRES_PASSWORD=pgbench -d postgres:"$(echo "$image" | tail -c 4)"
  docker exec "$image" pg_isready -t 20

  for query_mode in simple extended prepared
  do
    for n_threads in 1 2 4 8 16 32
    do
      echo "Running pgbench for image $image with $n_threads threads and $query_mode query mode."
      echo pgbench | docker run -i --rm --link "$image":postgres postgres:"$(echo "$image" | tail -c 4)" pgbench -i -h postgres -U postgres
      echo pgbench | docker run -i --rm --link "$image":postgres postgres:"$(echo "$image" | tail -c 4)" pgbench -h postgres -U postgres -M "$query_mode" -t "$n_threads" > "$GITHUB_WORKSPACE"/pipelines/pgbench/results_/"$image"-"$n_threads"-"$query_mode".results
    done
  done
done
