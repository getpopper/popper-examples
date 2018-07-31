#!/bin/bash
set -e -x
docker run --rm -v `pwd`/results:/blistest/output blis:0.2.1-reference
