#!/bin/sh

GIT_URL="https://github.com/fireice-uk/xmr-stak-cpu.git"
GIT_BRANCH="master"

BIN="xmr-stak-cpu"

TMP="/tmp/build"
OUT="/tmp/out"

download(){
    git clone "$GIT_URL" -b "$GIT_BRANCH" $TMP 
    cd $TMP
}

prebuild(){
    echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
    apk update
    apk add hwloc hwloc-dev hwloc-tools

    cmake -DCMAKE_LINK_STATIC=ON  -DMICROHTTPD_ENABLE=OFF .
}

build(){
    make -j$(nproc)
}

deploy(){
   mv $TMP/bin/xmr-stak-cpu $OUT/$BIN
}

download && \
prebuild && \
build && \
deploy 

