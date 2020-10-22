#!/bin/bash

set -e

#cp -R "/home/kek/build/tmp_reduced_corpus" "/home/kek/out/tmp_reduced_corpus"
if [ ! -d "/home/kek/out/tmp_reduced_fuzzing" ]; then
    cp -R "/home/kek/build/tmp_reduced_corpus" "/home/kek/out/"
fi

#../pwnbois_fuzz tmp_reduced_corpus -rss_limit_mb=2000
../pwnbois_fuzz tmp_reduced_corpus -rss_limit_mb=32000 -dict=../build/gif.dict
