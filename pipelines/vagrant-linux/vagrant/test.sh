#!/bin/bash
set -ex

iterations=10
quota=5000
period=10000

ls -l ~/

echo "iteration,cgroups_enabled,result" > ~/results/all.csv

bench="ivotron/stress-ng --cpu 1 --timeout 10 --metrics-brief --times"

for i in $(seq 0 $iterations) ; do
  # run without limits

  result=`docker run --rm -ti $bench | grep -P "cpu *\d" | awk '{ print $10 }'`
  
  echo "$i,false,$result" >> ~/results/all.csv

  # run with limits
  result=`docker run --rm -ti --cpu-period=$period --cpu-quota=$quota $bench | grep -P "cpu *\d" | awk '{ print $10 }'`
  echo "$i,true,$result" >> ~/results/all.csv
done
