#!/usr/bin/env bash
# [wf] execute run.sh stage

if [ -z "$N_REPETITIONS" ]; then
  echo "N_REPETITIONS environment variable needs to be set" >&2
  exit 1
fi

for i in $(seq 1 $N_REPETITIONS)
do
  echo "Done with $i"
done

