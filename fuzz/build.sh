#!/bin/bash

rm -rf CMakeFiles/
rm -f CMakeCache.txt
rm -f cmake_install.cmake
rm -f Makefile

export CC=$(which clang)
export CXX=$(which clang++)

cmake .
make
