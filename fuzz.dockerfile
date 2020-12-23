FROM ubuntu:20.04

ENV TRAVIS_BUILD 0
ENV LD_LIBRARY_PATH /workdir/build/bin
ENV CC clang
ENV CXX clang++

COPY . /workdir

WORKDIR /workdir

RUN .travis/install-ubuntu.sh && .travis/install-post.sh && \
      mkdir -p build && cd build && \
      cmake -G Ninja -DSANITIZE_ADDRESS:BOOL=ON .. && ninja && \
      cd /workdir/fuzz && \
      clang++ -lGameNetworkingSockets fuzz_process_packet.cpp \
        -o fuzz_process_packet \ 
        -L../build/bin/ \
        -I../include \
        -fsanitize=fuzzer,address \
        -std=gnu++11 
