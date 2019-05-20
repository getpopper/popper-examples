FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git scala wget && \
    wget "http://mirrors.estointernet.in/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz" && \
    tar xvf "spark-2.4.3-bin-hadoop2.7.tgz" && \
    git clone "https://github.com/Intel-bigdata/HiBench"