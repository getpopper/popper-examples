#!/usr/bin/env bash
set -ex
gunzip ./workflows/spparks/spparks.tar.gz
mkdir -p ./workflows/spparks/SPPARKS
tar xf ./workflows/spparks/spparks.tar -C workflows/spparks/SPPARKS --strip-components=1

cp ./workflows/spparks/submodules/sppark-demo/Makefile.demo workflows/spparks/SPPARKS/src/MAKE
cp ./workflows/spparks/submodules/sppark-demo/Makefile.demo_serial workflows/spparks/SPPARKS/src/MAKE

cd workflows/spparks/SPPARKS/src/STUBS
make
cd ..

make clean; make demo_serial
