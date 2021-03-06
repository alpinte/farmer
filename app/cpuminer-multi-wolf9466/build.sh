#!/bin/sh

GIT_URL="https://github.com/OhGodAPet/cpuminer-multi.git"
BIN="cpuminer-multi-wolf9466"

TMP="/tmp/build"
OUT="/tmp/out"

download(){
    git clone $GIT_URL $TMP
    cd $TMP
}

prebuild(){
    ./autogen.sh

    CFLAGS="-static -O2 -march=native" \
    CXXFLAGS="-static -O2 -march=native" \
    LIBS="-lz -lssh2" \
    LDFLAGS="-Wl,-static -static -static-libgcc -s" \
    ./configure
}

build(){
    make -j$(nproc)
}

deploy(){
   mv $TMP/minerd $OUT/$BIN
}

download && \
prebuild && \
build && \
deploy

