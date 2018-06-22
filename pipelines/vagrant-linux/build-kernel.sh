#!/bin/bash
set -e -x

KERNEL_TARBALL_URL=${KERNEL_TARBALL_URL:-"https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/linux-$KERNEL_VERSION.tar.xz"}

echo $KERNEL_VERSION

# git clone https://github.com/torvalds/linux.git

mkdir -p linux

pushd linux
curl -O https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/linux-$KERNEL_VERSION.tar.xz
popd

# build deb packages
rm -f vagrant/debs/*
docker build -t kernel-ci docker/
docker run --rm -e KERNEL_VERSION=$KERNEL_VERSION -ti -v `pwd`/linux:/sources kernel-ci
mkdir -p vagrant/debs/
mv linux/*.deb vagrant/debs/
