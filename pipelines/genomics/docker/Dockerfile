# Use an official Python runtime as a parent image
FROM ubuntu:16.04

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app
# Install all the dependencies
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y default-jdk software-properties-common && \
  apt-get install -y wget unzip apt-utils curl sudo zlib1g-dev libncurses5-dev bzip2 libbz2-dev liblzma-dev && \
  rm -rf /var/lib/apt/lists/*
