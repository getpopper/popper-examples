
# start with the official R project base image
FROM ubuntu:16.04

# copy this github repo into the Docker image and set as the working directory
COPY . /app
WORKDIR /app

# Install the C/C++ libraries needed to run the script
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:marutter/rrutter \
    && apt update -y \
    && add-apt-repository -y ppa:ubuntugis/ppa \
    && apt update \
    && apt upgrade -y \
    && apt full-upgrade -y  \
    && gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 \
    && gpg -a --export E084DAB9 | apt-key add - \
    && apt-get update -y \
    && apt-get install -y r-base r-base-dev \
    && apt-get install -y libcurl4-gnutls-dev \
    && apt-get install -y libcurl4-openssl-dev libssl-dev \
    && apt-get update -y \
    && apt-get install -y r-base-core \
    && apt-get install -y r-recommended \
    && apt-get update -y  && apt-get upgrade -y \
    && apt-get install -y libgdal-dev \
    && apt-get install libproj-dev -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libudunits2-dev \
    python2.7-dev \
    python-pip
