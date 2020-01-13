#!/bin/sh

# get https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
curl -s -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
    /bin/bash miniconda.sh -b && \
    rm miniconda.sh
source ~/miniconda3/bin/activate

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

conda install -y -c bioconda ncbi-amrfinderplus

    curl --silent \
         -O https://raw.githubusercontent.com/ncbi/amr/master/test_dna.fa \
         -O https://raw.githubusercontent.com/ncbi/amr/master/test_prot.fa \
         -O https://raw.githubusercontent.com/ncbi/amr/master/test_prot.gff \
         -O https://raw.githubusercontent.com/ncbi/amr/master/test_both.expected \
         -O https://raw.githubusercontent.com/ncbi/amr/master/test_dna.expected \
         -O https://raw.githubusercontent.com/ncbi/amr/master/test_prot.expected


    ./amrfinder -u
    ./amrfinder --plus -p test_prot.fa -g test_prot.gff -O Escherichia > test_prot.got
    diff test_prot.expected test_prot.got
    echo "ok 1 nucleotide test"
    ./amrfinder --plus -n test_dna.fa -O Escherichia > test_dna.got
    diff test_dna.expected test_dna.got
    echo "ok 2 protein tests"
    ./amrfinder --plus -n test_dna.fa -p test_prot.fa -g test_prot.gff -O Escherichia > test_both.got
    diff test_both.expected test_both.got
    echo "ok 3 combined test"

exit 0

