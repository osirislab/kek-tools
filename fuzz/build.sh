#!/bin/bash

set -e

cd $(dirname $(realpath $0))

mkdir -p build bin
cd build

rm -rf CMakeFiles/
rm -f CMakeCache.txt
rm -f cmake_install.cmake
rm -f Makefile

export CC=$(which clang)
export CXX=$(which clang++)

cmake ..
make -j $(nproc)

cp pwnbois_fuzz ../bin
