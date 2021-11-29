# ExperimentalDesign I & II
## Docker Installation, Downlad and Basic Use Instructions

### Docker Installation Setup

1. go to (https://docs.docker.com/get-docker/) and follow the instructions to download docker desktop for you operating system. The landing page should look something like: ()
2. Once docker is downloaded and installed open a terminal (Mac and Linux search for the 'Terminal' application; Windows search for the 'Command Prompt Application')
3. Copy and paste the following command into the window `docker pull enluchicago/experimental_design:latest`
4. Thats it! See below for basic usage.


## Basic Usage

### Running the docker and accessing R Studio in the browser

1. Copy and paste the following command into your browser of choice: `docker run --rm -e PASSWORD=pwd -p 8787:8787` **make sure to replace `pwd` with a password of your choice**



docker run --rm -e PASSWORD=pwd -p 8787:8787 -v path-to-work-directory-on-local-computer:/home/expdes enluchicago/experimental_design:latest

on my computer I might replace path-to-work-directory-on-local-computer with /home/andrewstier/Downloads
and replace pwd with stiera

In a browser window type http://localhost:8787/

sign in with username "expdes" and the password you choose
