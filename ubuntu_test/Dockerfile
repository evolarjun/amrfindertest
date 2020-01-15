FROM ubuntu:18.04

RUN apt-get update && apt-get install -y hmmer ncbi-blast+ git libcurl4-openssl-dev build-essential curl
# RUN git clone https://github.com/ncbi/amr.git && cd amr && git checkout v2 && make && make install && cd ..
# RUN amrfinder -u

# set up a working directory for the test
WORKDIR /usr/src/amrfindertest

# install miniconda 
# idea from (https://github.com/ContinuumIO/docker-images/blob/master/miniconda/debian/Dockerfile)
RUN curl -s -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash miniconda.sh -b && \
    rm miniconda.sh && \
    . ~/miniconda3/bin/activate && \
    conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    find ~/miniconda3/ -follow -type f -name '*.a' -delete && \
    find ~/miniconda3/ -follow -type f -name '*.js.map' -delete && \
    ~/miniconda3/bin/conda clean -afy


# copy all files in this directory into that directory
COPY . .  
#COPY .bash_profile /root

#CMD prove -v 80_source_v2.t 81_binary_release.t 82_source_master.t 83_conda_release.t
