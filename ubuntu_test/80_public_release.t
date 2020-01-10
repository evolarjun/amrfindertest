#!/bin/bash
echo 1..3 # for TAP

set -e 

# found and lightly modified these functions
get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | 
    grep '"tag_name":' |                                            
    cut -d '"' -f 4                                    
}

get_tarball_url() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" |
        fgrep '"browser_download_url":' |
        cut -d '"' -f 4
}
    

release=$(get_latest_release ncbi/amr)
URL=$(get_tarball_url ncbi/amr)


>&2 echo "$release is the latest release"

if [ -e "$release" ]
then
    >&2 echo "directory $release already exists so deleting and re-downloading"
    rm -r $release
fi
mkdir $release
cd $release

# download and unpack AMRFinder binaries
    curl --silent -L -O $URL
    tarball_name=$(echo $URL | perl -pe 's#^.*/(.*)#\1#')
    tar xfz $tarball_name
    rm $tarball_name

# download and unpack test
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

cd ..
# if we got here we succeeded so delete the test directory
#rm -r $release
# test bioconda release?
exit 0
