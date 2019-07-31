FROM debian:buster-slim

RUN apt update && \
    apt install -y build-essential curl \
      mpich python python-pip && \
    pip install --no-cache-dir numpy && \
    rm -rf /var/lib/apt/lists/* && \
    curl -Lo /tmp/spparks.tar.gz http://www.sandia.gov/~sjplimp/tars/spparks.tar.gz && \
    gunzip /tmp/spparks.tar.gz && \
    mkdir -p SPPARKS && \
    tar xf /tmp/spparks.tar -C SPPARKS --strip-components=1

COPY ./makeconf/Makefile.demo SPPARKS/src/MAKE
COPY ./makeconf/Makefile.demo_serial SPPARKS/src/MAKE

RUN cd SPPARKS/src/STUBS && make && cd .. && \
    make clean; make demo_serial

ENV spk /SPPARKS/src/spk_demo_serial
