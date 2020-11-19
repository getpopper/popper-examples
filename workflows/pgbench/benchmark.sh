#!/usr/bin/env sh
set -ex

if [ -z "$PG_IMAGES" ]; then
  echo "Expecting PG_IMAGES variable"
  exit 1
fi
if [ -z "$PG_SCALE_FACTOR" ]; then
  echo "Expecting PG_SCALE_FACTOR variable"
  exit 1
fi

outdir="$GITHUB_WORKSPACE/workflows/pgbench/results"

rm -rf "$outdir"
mkdir -p "$outdir"

# get the list of images to test
images=$(echo "$PG_IMAGES" | sed 's/ //g' | sed 's/,/ /g')

for image in $images; do
  # get container name
  cid="pgbench-$(echo "$image" | sed 's/:/-/')"

  # stop (if previous was running)
  docker stop "$cid" || true

  # create container
  docker run --rm --name "$cid" -e POSTGRES_PASSWORD=pgbench -d "$image"

  # give docker some time to instantiate the container
  sleep 10

  # wait for server to boot
  docker exec "$cid" pg_isready -t 20

  # initialize test database
  echo pgbench | docker run -i --rm \
    --link "$cid":postgres "$image" \
      pgbench -i -s "$PG_SCALE_FACTOR" -h postgres -U postgres

  for mode in simple extended prepared; do
    for threads in 1 2 4 8; do

      outfile="$outdir/$image-$threads-$mode.results"

      echo "Running $image with $threads threads and $mode query mode."

      # run benchmark
      echo pgbench | docker run -i --rm \
        --link "$cid":postgres "$image" \
          pgbench -h postgres -U postgres -M "$mode" -t "$threads" > "$outfile"
    done
  done

  # stop the container
  docker stop "$cid"
done
