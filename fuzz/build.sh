#!/bin/bash

cd $(realpath $(dirname $0))

mkdir -p build
cd build

rm -rf CMakeFiles/
rm -f CMakeCache.txt
rm -f cmake_install.cmake
rm -f Makefile

export CC=$(which clang)
export CXX=$(which clang++)

cmake ..
make -j $(nproc)

cp build/pwnbois_fuzz ./
