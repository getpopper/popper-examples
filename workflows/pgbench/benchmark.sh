#!/usr/bin/env sh
set -ex

echo "$PG_IMAGES"
rm -rf "$GITHUB_WORKSPACE/workflows/pgbench/results/"


mkdir -p "$GITHUB_WORKSPACE/workflows/pgbench/results"

for image in $(echo "$PG_IMAGES" | sed "s/,/ /g")
do
  docker run --name "$(echo "$image" | sed -e "s/://g")" -e POSTGRES_PASSWORD=pgbench -d "$image"
  sleep 5
  docker exec "$(echo "$image" | sed -e "s/://g")" pg_isready -t 20

  for query_mode in simple extended prepared
  do
    for n_threads in 1 2 4 8 16 32
    do
      echo "Running pgbench for image $image with $n_threads threads and $query_mode query mode."
      echo pgbench | docker run -i --rm \
                    --link "$(echo "$image" | sed  -e "s/://g")":postgres "$image" \
                    pgbench -i -h postgres -U postgres
      echo pgbench | docker run -i --rm \
                    --link "$(echo "$image" | sed  -e "s/://g")":postgres "$image" \
                    pgbench -h postgres -U postgres -M "$query_mode" \
                    -t "$n_threads" > "$GITHUB_WORKSPACE"/workflows/pgbench/results/"$image"-"$n_threads"-"$query_mode".results
    done
  done
done
