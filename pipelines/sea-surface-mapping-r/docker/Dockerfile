
# start with the official R project base image
FROM ubuntu:16.04

# copy this github repo into the Docker image and set as the working directory
COPY . /app
WORKDIR /app

# Install the C/C++ libraries needed to run the script
RUN apt-get update

RUN apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:marutter/rrutter \
    && add-apt-repository -y ppa:ubuntugis/ppa

RUN apt update && apt upgrade -y && apt full-upgrade -y  \
    && gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 \
    && gpg -a --export E084DAB9 | apt-key add -

RUN apt-get update

RUN apt-get install -y \
    r-base r-base-dev libcurl4-gnutls-dev libcurl4-openssl-dev libssl-dev r-base-core r-recommended libgdal-dev \
    libproj-dev libssl-dev libcurl4-openssl-dev libxml2-dev libudunits2-dev python2.7-dev python-pip



