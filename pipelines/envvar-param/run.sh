#!/usr/bin/env bash
# [wf] execute run.sh stage

# Check that N_REPETITIONS is set
if [ -z "$N_REPETITIONS" ]; then
  # Output error message to stderr
  echo "N_REPETITIONS environment variable needs to be set" >&2
  exit 1
fi

for i in $(seq 1 $N_REPETITIONS)
do
  echo "Done with $i"
done

