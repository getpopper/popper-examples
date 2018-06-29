#!/bin/bash

# [wf] Check if PLOTY_USERNAME environment variable is set
if [ -z "$PLOTY_USERNAME" ]; then
  echo "ERROR: PLOTY_USERNAME environment variable needs to be set"
  exit 1
fi

# [wf] Check if PLOTY_API_KEY environment variable is set
if [ -z "$PLOTY_API_KEY" ]; then
  echo "ERROR: PLOTY_API_KEY environment variable needs to be set"
  exit 1
fi

# [wf] Make data folder

mkdir data

# [wf] script for generating data
Rscript scripts/generate_map.r
