FROM ubuntu:20.04

VOLUME /home/kek/out
ENV CC=clang CXX=clang++
RUN apt update \
  && apt install -y g++-multilib clang llvm libfuzzer-10-dev cmake ninja-build \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/kek/build
COPY . .

RUN cmake -B . -G Ninja . \
  && ninja \
  && cd .. \
  && mv build/pwnbois_fuzz ./ \
  && mv build/tmp_reduced_corpus ./

WORKDIR /opt/kek/out

CMD ["../pwnbois_fuzz", "../tmp_reduced_corpus", "-rss_limit_mb=2000"]
