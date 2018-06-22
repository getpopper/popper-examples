#!/bin/bash
set -e -x
docker run --rm -v `pwd`/results:/blis/test/output blis:0.2.1-reference
