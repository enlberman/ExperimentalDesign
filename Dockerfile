
# Base r from https://hub.docker.com/u/rocker/
FROM rocker/tidyverse:devel

## Copy requirements.R to container directory /tmp
COPY ./DockerConfig/requirements.R /tmp/requirements.R 

# Define Libsodium version
ENV LIBSODIUM_VERSION 1.0.18

# Define workdir
WORKDIR /root

### we need lib sodium first
# Install some tools: gcc build tools, unzip, etc
RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl build-essential unzip locate

# Download and install libsodium
# https://download.libsodium.org/doc/

# Download & extract & make libsodium
# Move libsodium build
RUN \
    mkdir -p /tmpbuild/libsodium && \
    cd /tmpbuild/libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/libsodium-${LIBSODIUM_VERSION}.tar.gz -o libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    tar xfvz libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    cd /tmpbuild/libsodium/libsodium-${LIBSODIUM_VERSION}/ && \
    ./configure && \
    make && make check && \
    make install && \
    mv src/libsodium /usr/local/ && \
    rm -Rf /tmpbuild/
    
## install required R libraries
RUN Rscript /tmp/requirements.R

# create an R user
ENV USER expdes

RUN mkdir /home/$USER/

RUN mkdir /home/$USER/public
RUN mkdir /home/$USER/templates
RUN mkdir /home/$USER/outputs
RUN mkdir /home/$USER/test_files
RUN mkdir /home/$USER/data
RUN mkdir /home/$USER/public/grdg
RUN mkdir /home/$USER/public/grdg/srcs

COPY ./Data/id_rsa /home/$USER/public/
COPY ./Data/hw1_test.encryptr.bin /home/$USER/test_files/
COPY ./Data/getGrades.r /home/$USER/public/grdg/srcs
COPY ./Data/sampledata.txt /home/$USER/data
COPY ./Data/HW1_template.RMD /home/$USER/templates
## Copy your working files over
## The $USER defaults to `rstudio` but you can change this at runtime
#COPY ./Analysis /home/$USER/Analysis
#COPY ./Data /home/$USER/Data
