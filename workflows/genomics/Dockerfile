FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
      curl build-essential unzip \
      zlib1g-dev libncurses5-dev bzip2 libbz2-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*; \

    curl -o tbwa.tar.bz2 -0L https://sourceforge.net/projects/bio-bwa/files/latest/download && \
    tar -xjf tbwa.tar.bz2 && \
    cd bwa* && make && cd ..; \

    curl -o tsamtools.tar.bz2 -0L https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2 && \
    tar -xjf tsamtools.tar.bz2 && \
    cd samtools* && ./configure && make && make install && cd .. ; \

    curl -o tbcftools.tar.bz2 -0L https://github.com/samtools/bcftools/releases/download/1.8/bcftools-1.8.tar.bz2 && \
    tar -xjf tbcftools.tar.bz2 && \
    cd bcftools* && ./configure && make && make install

