#!/usr/bin/env bash
# [wf] execute analyze.sh stage

docker run -v `pwd`/results:/app/results dspython

