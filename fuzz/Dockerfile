FROM ubuntu:20.04

ENV CC=clang CXX=clang++
RUN apt update \
  && apt install -y g++-multilib clang llvm libfuzzer-10-dev cmake ninja-build \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -m kek
WORKDIR /home/kek/build
COPY . .

RUN cmake -B . -G Ninja . \
  && ninja \
  && cd .. \
  && mv build/pwnbois_fuzz ./ \
  && rm -rf build/* \
  && chown kek:kek -R /home/kek

WORKDIR /home/kek

USER kek

CMD ./pwnbois_fuzz
