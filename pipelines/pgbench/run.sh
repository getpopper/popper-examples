#!/usr/bin/env bash
# [wf] execute run stage

PG_IMAGES=${PG_IMAGES:-9.6,9.3}

MAX_ATTEMPS=4

rm results/*

sleep 5

for image in $(echo $PG_IMAGES | sed "s/,/ /g")
do
  docker exec pg$image pg_isready -t 20

  for query_mode in simple extended prepared
  do
    for n_threads in 1 2 4 8 16 32
    do
      echo "Running pgbench for image $image with $n_threads threads and $query_mode query mode."
      echo pgbench | docker run -i --rm --link pg$image:postgres postgres:$image pgbench -i -h postgres -U postgres
      echo pgbench | docker run -i --rm --link pg$image:postgres postgres:$image pgbench -h postgres -U postgres -M $query_mode -t $n_threads > results/$image-$n_threads-$query_mode.results
    done
  done
done

