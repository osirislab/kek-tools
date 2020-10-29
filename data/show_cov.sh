#!/bin/bash

set -e

llvm-profdata merge -sparse out/kek-run*/*.profraw -o default.profdata
llvm-cov show ../fuzz/build/pwnbois_fuzz -instr-profile=default.profdata
