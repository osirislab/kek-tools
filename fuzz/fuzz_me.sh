#!/bin/bash

# A pwnbois 2020 production

#
# Fuzz the shit out of this gif library
#
# plz make sure you have at least 8 cores, 16 threads and 32GB of RAM
#

set -e

cd $(dirname $(realpath $0))

if [ ! -f ./bin/pwnbois_fuzz ]; then
  ./build.sh
fi

cd bin
mkdir -p output
cd output

../pwnbois_fuzz -rss_limit_mb=32000 -jobs=16 -workers=16