FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
      build-essential curl libmpich-dev libjpeg-dev python-pip && \
    pip install --no-cache-dir numpy && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LO http://www.sandia.gov/~sjplimp/tars/spparks.tar.gz && \
    tar xfz spparks.tar.gz && \
    mv spparks-18May17 spparks && \
    cd spparks/src && \
    make CC=mpicxx g++ && \
    mv spk_g++ /usr/bin/spk && \
    cd / && \
    rm -r /spparks*
