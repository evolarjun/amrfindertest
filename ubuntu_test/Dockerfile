FROM ubuntu:18.04

RUN apt-get update && apt-get install -y hmmer ncbi-blast+ git libcurl4-openssl-dev build-essential curl
# RUN git clone https://github.com/ncbi/amr.git && cd amr && git checkout v2 && make && make install && cd ..
# RUN amrfinder -u

# set up a working directory for the test
WORKDIR /usr/src/amrfindertest

# copy all files in this directory into that directory
COPY . .  

# install miniconda 
# modified from (https://github.com/ContinuumIO/docker-images/blob/master/miniconda/debian/Dockerfile)
RUN curl -s -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
    /bin/bash miniconda.sh -b && \
    rm miniconda.sh && \
    source ~/miniconda3/bin/activate && \
    conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy



#RUN bash 80_public_release.t
