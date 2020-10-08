#!/bin/bash

set -e

cd $(dirname $(realpath $0))

mkdir -p build bin

cmake -B build -G Ninja .
ninja -C build
