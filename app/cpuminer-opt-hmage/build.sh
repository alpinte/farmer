#!/bin/sh

GIT_URL="https://github.com/hmage/cpuminer-opt.git"
GIT_BRANCH="master"

BIN="cpuminer-opt-hmage"

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
    LIBS="-lz -lssh2 -lgmp -lcurl" \
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

