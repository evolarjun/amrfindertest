# amrfindertest

This is to work out some ideas for testing AMRFinderPlus installation using Docker containers
to be able to test installation on multiple different linux distributions.

Thanks to ctSkennerton for the idea on https://github.com/ncbi/amr/issues/20

Currently testing stuff in ubuntu_test. My plan is to make test installations on
several OSs possible in docker containers.

    cd ubuntu_test
    docker build -t evolarjun/amrfindertest .
    docker run -it evolarjun/amrfindertest sh run_tests.sh

