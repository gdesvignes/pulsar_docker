# pulsar_docker
Builds a docker image for a pulsar analysis packages and few extras on Ubuntu 22.04 LTS (Jammy Jellyfish). Forked from https://github.com/vivekvenkris/pulsar_docker that is itself forked from https://github.com/mserylak/pulsar_docker

You'll find all pulsar software in /home/psr/software, environment variables are set according to ~/.mysetenv.bash file.

To build:

    docker build -t gd_psr_docker .
    
# USE in Docker:

To run image in docker:

    docker run -it gd_psr_docker /bin/bash 

To mount data directory into the docker container with the -v flag:

    docker run -it -v <data_location on host>:/data gd_psr_docker /bin/bash

This will drop you in to an ubuntu os with bash shell with all data in /data.

To run the image with X11 and mounted data directory, run the container first:

    docker run -d -p 2222:22 -p 9000:9000 -v <data_location on host>:/data gd_psr_docker

Check if container is running with docker ps -a. You can log in using **psr** as password:

    ssh -XY psr@localhost -p 2222

# USE Jupyter Notebook

To create the ssh tunnel to the Docker:

    ssh -p 2222 -f -N -L 9000:localhost:9000 -o ConnectTimeout=5 -o TCPKeepAlive=yes psr@localhost

To run Jupyter on the Docker:

    jupyter notebook --port=9000 --no-browser  

# USE in Singularity:

To use the docker image in singularity, you probably need to change the CACHE and TMP dirs that Singularity uses or you will get a ```NO SPACE LEFT ON DEVICE``` error. Set the following environment variables to a directory of your choice. 

    export SINGULARITY_LOCALCACHEDIR=/fpra/mkat/01/users/vivek
    export SINGULARITY_CACHEDIR=/fpra/mkat/01/users/vivek
    export SINGULARITY_TMPDIR=/fpra/mkat/01/users/vivek

    singularity shell -B <host_directory>:<singularity_dir> <path_to_singularity_image>

# Issues
Report problems to gdesvignes@mpifr-bonn.mpg.de
