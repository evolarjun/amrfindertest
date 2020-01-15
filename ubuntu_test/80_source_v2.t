#!/bin/bash
echo 1..3 # for TAP

set -e 

>&2 echo "Testing assembly of v2 branch (used for development)"

if [ -d "amr" ]
then
    rm -rf amr
fi

curl -fsSL  https://github.com/ncbi/amr/archive/v2.tar.gz | tar xz

cd amr-2
    make

    ./amrfinder -u
    ./amrfinder --plus -p test_prot.fa -g test_prot.gff -O Escherichia > test_prot.got
    diff test_prot.expected test_prot.got
    echo "ok 1 v2 branch nucleotide test"
    ./amrfinder --plus -n test_dna.fa -O Escherichia > test_dna.got
    diff test_dna.expected test_dna.got
    echo "ok 2 v2 branch protein tests"
    ./amrfinder --plus -n test_dna.fa -p test_prot.fa -g test_prot.gff -O Escherichia > test_both.got
    diff test_both.expected test_both.got
    echo "ok 3 v2 branch combined test"
