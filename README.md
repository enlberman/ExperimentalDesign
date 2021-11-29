# ExperimentalDesign I & II
## Docker Installation, Downlad and Basic Use Instructions

### Docker Installation Setup

1. go to (https://docs.docker.com/get-docker/) and follow the instructions to download docker desktop for you operating system. The landing page should look something like: ![](https://github.com/enlberman/ExperimentalDesign/blob/main/docker%20options.png)
2. Once docker is downloaded and installed open a terminal (Mac and Linux search for the 'Terminal' application; Windows search for the 'Command Prompt Application')
3. Copy and paste the following command into the window `docker pull enluchicago/experimental_design:latest`
4. Thats it! See below for basic usage.


## Basic Usage

### Running the docker and accessing R Studio in the browser

1. Copy and paste the following command into your browser of choice: `docker run --rm -e PASSWORD=pwd -p 8787:8787 enluchicago/experimental_design:latest` **make sure to replace** `pwd` **with a password of your choice**
2. In a browser window go to (http://localhost:8787/) and enter the username `expdes` and the password you chose above. This should look like a normal R Studio window. ![](https://github.com/enlberman/ExperimentalDesign/blob/main/r%20studio.png)
3. Congrats you can now use R-Studio and have all of the dependencies for the course already setup. [^1]

[^1]: Note that even though we are using the browser to interact with R-Studio, all of the code is being run on your computer and not through the browser. You can check this for yourself by pulling up a system monitor while you run something computationally intenstive. 


### Linking folders on your computer to the docker container *(VERY IMPORTANT)*

It is important to remember that docker containers are self contained operating systems and **anything you save locally to a docker container will be erased when you restart the container**. 

We can get around this by linking folders on our computer to folders on the container. This is done by adding the option `-v path-to-work-directory-on-local-computer:/home/expdes` to the `docker run` command. This will link the folder that you chose to the `/home/expdes` folder on the docker container and let you save your work and data outside of the container.

To setup a folder that you can use for both quarters of this class:

1. Make new folder on your computer to save all of your work and data. For example I might make the folder `/home/andrewstier/Classes/ExperimentalDesignI_II`, which is a subfolder of my existing `Classes` folder. 
2. Use the following command whenever you start the docker container `docker run --rm -e PASSWORD=pwd -p 8787:8787 -v path-to-work-directory-on-local-computer:/home/expdes enluchicago/experimental_design:latest`

For my folder that I created this would look like `docker run --rm -e PASSWORD=pwd -p 8787:8787 -v /home/andrewstier/Classes/ExperimentalDesignI_II:/home/expdes enluchicago/experimental_design:latest`

Once I have done this I can make new files that save into this folder! ![](https://github.com/enlberman/ExperimentalDesign/blob/main/hello.png)
