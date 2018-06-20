#!/bin/bash
set -e -x

# build deb packages

# provision new kernel and start VM


# run test
cd vagrant
vagrant ssh -c '/vagrant/test.sh'
vagrant halt -f

