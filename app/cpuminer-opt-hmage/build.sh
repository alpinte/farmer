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
    apk update
    apk add gmp gmp-dev

    for patch in /tmp/run/patch/*.patch;
    do
        git apply $patch
    done
    rm -f config.status
    ./autogen.sh

    CFLAGS="-O3 -march=native -Wall -D_REENTRANT -static" \
    CXXFLAGS="$CFLAGS -std=gnu++11" \
    LDFLAGS="-Wl,-static -static -static-libgcc -s" \
    LIBS="${LIBS} -lssh2 -lgmp -lz -lcrypto" \
    ./configure --with-curl
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

