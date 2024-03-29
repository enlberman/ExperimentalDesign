
# Base r from https://hub.docker.com/u/rocker/
FROM rocker/tidyverse:devel

## Copy requirements.R to container directory /tmp
COPY ./DockerConfig/requirements.R /tmp/requirements.R 

# Define Libsodium version
ENV LIBSODIUM_VERSION 1.0.18

# Define workdir
WORKDIR /root

# create an R user
ENV USER expdes

RUN mkdir /home/$USER/
RUN mkdir /home/$USER/.cmdstanr

RUN mkdir /home/$USER/public
RUN mkdir /home/$USER/demos
RUN mkdir /home/$USER/demos/OnlineExperiment
RUN mkdir /home/$USER/templates
RUN mkdir /home/$USER/outputs
RUN mkdir /home/$USER/test_files
RUN mkdir /home/$USER/data
RUN mkdir /home/$USER/data/experimentaldata
RUN mkdir /home/$USER/public/grdg
RUN mkdir /home/$USER/public/grdg/srcs

COPY ./Data/id_rsa /home/$USER/public/
COPY ./Data/hw1_test.encryptr.bin /home/$USER/test_files/
COPY ./Data/getGrades.r /home/$USER/public/grdg/srcs
COPY ./Data/sampledata.txt /home/$USER/data
COPY ./Data/HW1_template.RMD /home/$USER/templates
COPY ./Data/SamplingDistributions_2022.Rmd /home/$USER/demos
COPY ./Data/SamplingDistributions_2022.html /home/$USER/demos
COPY ./Data/DataVisualization.Rmd /home/$USER/demos
COPY ./Data/2020ExpData/*.txt /home/$USER/demos/OnlineExperiment
COPY ./Data/experimentaldata/*.txt /home/$USER/data/experimentaldata
COPY ./Data/hw2_test.encryptr.bin /home/$USER/test_files/
COPY ./Data/Homework2_template.Rmd /home/$USER/templates
COPY ./Data/power_demo.Rmd /home/$USER/demos
COPY ./Data/PermutationTests.Rmd /home/$USER/demos
COPY ./Data/test_data.csv /home/$USER/data
COPY ./Data/test_data_by_sub.csv /home/$USER/data
COPY ./Data/hw3_test.encryptr.bin /home/$USER/test_files
COPY ./Data/Homework3_template.Rmd /home/$USER/templates
COPY ./Data/MultipleComparisonCorrections_2022.Rmd /home/$USER/demos
COPY ./Data/Study1_ParkEntryAvgs.csv /home/$USER/demos
COPY ./Data/test_data_hw3.csv /home/$USER/data
COPY ./Data/test_data_by_sub_hw3.csv /home/$USER/data
COPY ./Data/imidtomemorabilityscore.csv /home/$USER/data
COPY ./Data/hw4_test.encryptr.bin /home/$USER/test_files
COPY ./Data/HW4_template.Rmd /home/$USER/templates
COPY ./Data/ChiSquare_F_Dists.Rmd /home/$USER/demos
COPY ./Data/BestFitLines_demo_2022.Rmd /home/$USER/demos
COPY ./Data/RegressionData1.csv /home/$USER/demos
COPY ./Data/RegressionImageData.csv /home/$USER/demos
COPY ./Data/Regression_demo_2022.Rmd /home/$USER/demos
COPY ./Data/cor.mtest.R /home/$USER/demos
COPY ./Data/by_image_rt_hw4.csv /home/$USER/data
COPY ./Data/hw5_test.encryptr.bin /home/$USER/test_files
COPY ./Data/Homework5_template.Rmd /home/$USER/templates
COPY ./Data/cross_validation_jb.Rmd /home/$USER/demos
COPY ./Data/hw6_test.encryptr.bin /home/$USER/test_files
COPY ./Data/Homework6_template.Rmd /home/$USER/templates
COPY ./Data/ANOVAs.Rmd /home/$USER/demos
COPY ./Data/useful_R_packages_2022.Rmd /home/$USER/demos

COPY ./Data/HW_1_q2_template.Rmd /home/$USER/templates
COPY ./Data/hw1_q2_test.encryptr.bin /home/$USER/test_files
COPY ./Data/HW_2_template_final_final.Rmd /home/$USER/templates
COPY ./Data/hw2_q2_test.encryptr.bin /home/$USER/test_files
COPY ./Data/HW_3_Template_Final.Rmd /home/$USER/templates
COPY ./Data/hw3_q2_test.encryptr.bin /home/$USER/test_files
COPY ./Data/HW_4_Template_Final.Rmd /home/$USER/templates
COPY ./Data/hw4_q2_test.encryptr.bin /home/$USER/test_files
COPY ./Data/NSED_SLJ_slim_data.csv /home/$USER/data
COPY ./Data/TorontoHealth.csv /home/$USER/data


#### install stan stuff
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*
    
RUN  \
    add-apt-repository ppa:marutter/rrutter4.0 && \
    add-apt-repository ppa:c2d4u.team/c2d4u4.0+
    
RUN yes | apt-get update

RUN yes | apt-get install r-cran-rstan

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


## install relevant x11 libraries for R
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libx11-6 \
    libxss1 \
    libxt6 \
    libxext6 \
    libsm6 \
    libice6 \
    xdg-utils \
  && rm -rf /var/lib/apt/lists/*
  
RUN apt-get -y update && apt-get install -y \ 
r-cran-nloptr \
cmake
  
# Define workdir
WORKDIR /home/$USER/

## install required R libraries
RUN Rscript /tmp/requirements.R


## Copy your working files over
## The $USER defaults to `rstudio` but you can change this at runtime
#COPY ./Analysis /home/$USER/Analysis
#COPY ./Data /home/$USER/Data
