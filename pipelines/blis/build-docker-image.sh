#!/bin/bash
set -ex

docker build -t blis:0.2.1-reference docker-blis/
docker build -t octave-alpine:3.5 docker-octave/
