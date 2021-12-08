
# Base r from https://hub.docker.com/u/rocker/
FROM rocker/tidyverse

## Copy requirements.R to container directory /tmp
COPY ./DockerConfig/requirements.R /tmp/requirements.R 
## install required R libraries
RUN Rscript /tmp/requirements.R

# create an R user
ENV USER expdes

RUN mkdir /home/$USER/

RUN mkdir /home/$USER/public
RUN mkdir /home/$USER/public/grdg
RUN mkdir /home/$USER/public/grdg/srcs

#COPY ./Data/id_rsa /home/$USER/public/
#COPY ./Data/getGrades.r /home/$USER/public/grdg/srcs
## Copy your working files over
## The $USER defaults to `rstudio` but you can change this at runtime
#COPY ./Analysis /home/$USER/Analysis
#COPY ./Data /home/$USER/Data
