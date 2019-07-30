FROM debian:buster-slim

RUN apt update && \
    apt install -y curl build-essential mpich python3 python3-venv dump && \
    rm -rf /var/lib/apt/lists/*

RUN curl -Lo /tmp/spparks.tar.gz http://www.sandia.gov/~sjplimp/tars/spparks.tar.gz && \
    gunzip /tmp/spparks.tar.gz && \
    mkdir -p SPPARKS && \
    tar xf /tmp/spparks.tar -C SPPARKS --strip-components=1

COPY ./submodules/sppark-demo/Makefile.demo SPPARKS/src/MAKE
COPY ./submodules/sppark-demo/Makefile.demo_serial SPPARKS/src/MAKE

RUN cd SPPARKS/src/STUBS && make && cd .. && \
    make clean; make demo_serial
ENV spk /SPPARKS/src/spk_demo_serial