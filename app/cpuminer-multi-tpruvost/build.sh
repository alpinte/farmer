#!/bin/sh

GIT_URL="https://github.com/tpruvot/cpuminer-multi.git"
GIT_BRANCH="linux"

BIN="cpuminer-multi-tpruvost"

TMP="/tmp/build"
OUT="/tmp/out"

download(){
    git clone "$GIT_URL" -b "$GIT_BRANCH" $TMP 
    cd $TMP
}

prebuild(){
    ./autogen.sh

    CFLAGS="-static -O2 -march=native" \ 
    CXXFLAGS="-static -O2 -march=native" \
    LIBS="-lz -lssh2" \
    LDFLAGS="-Wl,-static -static -static-libgcc -s" \
    ./configure --with-crypto --with-curl 
}

build(){
    make -j$(nproc)
}

deploy(){
   mv $TMP/cpuminer $OUT/$BIN
}

download && \
prebuild && \
build && \
deploy 

