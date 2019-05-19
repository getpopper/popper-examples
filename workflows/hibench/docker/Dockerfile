FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git scala wget && \
    wget "https://www.apache.org/dyn/closer.lua/spark/spark-2.4.1/spark-2.4.1-bin-hadoop2.7.tgz" && \
    tar xvf "spark-2.4.1-bin-hadoop2.7.tgz" && \
    git clone "https://github.com/Intel-bigdata/HiBench"