FROM debian:jessie AS base

ENV DEBIAN_FRONTEND noninteractive

ADD add_path_to_usrlib.patch /tmp/

RUN apt-get update && \
    apt-get install -y \
      g++ make gfortran curl libatlas-base-dev libopenblas-dev tar patch

FROM base AS build

RUN curl -sL https://github.com/flame/blis/archive/0.2.1.tar.gz | tar xz && \
    mv /blis-* /blis && \
    cd /blis && \
    patch -p0 < /tmp/add_path_to_usrlib.patch && \
    ./configure -p /usr/ reference && \
    make -j4 && \
    make install && \
    make -j4 -C test

FROM base

WORKDIR /blistest
ENTRYPOINT ["/blistest/runme.sh"]

COPY --from=build /usr/local /usr/local
COPY --from=build /blis/test /blistest
