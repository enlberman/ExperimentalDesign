
# Base r from https://hub.docker.com/u/rocker/
FROM rocker/tidyverse

## Copy requirements.R to container directory /tmp
COPY ./DockerConfig/requirements.R /tmp/requirements.R 
## install required R libraries
RUN Rscript /tmp/requirements.R

# create an R user
ENV USER expdes


## Copy your working files over
## The $USER defaults to `rstudio` but you can change this at runtime
#COPY ./Analysis /home/$USER/Analysis
#COPY ./Data /home/$USER/Data
