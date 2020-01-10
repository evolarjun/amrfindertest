FROM ubuntu:18.04

RUN apt-get update && apt-get install -y hmmer ncbi-blast+ git libcurl4-openssl-dev build-essential curl
RUN git clone https://github.com/ncbi/amr.git && cd amr && git checkout v2 && make && make install && cd ..
RUN amrfinder -u

# set up a working directory for the test
WORKDIR /usr/src/amrfindertest

# copy all files in this directory into that directory
COPY . .  

#RUN bash 80_public_release.t
CMD ["bash", "./80_public_release.t"]
