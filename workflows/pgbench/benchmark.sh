#!/usr/bin/env bash
set -ex

if [ -z "$PG_SCALE_FACTOR" ]; then
  echo "Expecting PG_SCALE_FACTOR variable"
  exit 1
fi

outdir="./results"
mkdir -p "$outdir"

export POSTGRES_PASSWORD=pgbench

bash -c 'cd / && docker-entrypoint.sh postgres &'

# give docker some time to instantiate the container
sleep 10

# wait for server to boot
pg_isready -t 20

# initialize test database
echo pgbench | pgbench -i -s "$PG_SCALE_FACTOR" -U postgres

version=$(postgres -V | awk '{ print $3 }')

for mode in simple extended prepared; do
  for threads in 1 2 4 8; do

    outfile="$outdir/$version-$threads-$mode.results"

    echo "Running postgres-$version with $threads threads and $mode query mode."

    # run benchmark
    echo pgbench | pgbench -U postgres -M "$mode" -t "$threads" > "$outfile"
  done
done
