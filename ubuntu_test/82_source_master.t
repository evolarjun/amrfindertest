#!/bin/bash
echo 1..3 # for TAP

set -e 

if [ -d "amr" ]
then
    rm -rf amr
fi

curl -fsSL  https://github.com/ncbi/amr/archive/master.tar.gz | tar xz
#wget https://github.com/ncbi/amr/archive/master.tar.gz
#tar xfz master.tar.gz
cd amr-master

>&2 echo "Testing assembly of master branch (used for releases)"

    make

    ./amrfinder -u
    ./amrfinder --plus -p test_prot.fa -g test_prot.gff -O Escherichia > test_prot.got
    diff test_prot.expected test_prot.got
    echo "ok 1 master branch nucleotide test"
    ./amrfinder --plus -n test_dna.fa -O Escherichia > test_dna.got
    diff test_dna.expected test_dna.got
    echo "ok 2 master branch protein tests"
    ./amrfinder --plus -n test_dna.fa -p test_prot.fa -g test_prot.gff -O Escherichia > test_both.got
    diff test_both.expected test_both.got
    echo "ok 3 master branch combined test"



exit 0
