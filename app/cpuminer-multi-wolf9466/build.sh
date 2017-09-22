#!/bin/sh

GIT_URL="https://github.com/OhGodAPet/cpuminer-multi.git"
BIN="cpuminer-multi-wolf9466"

TMP="/tmp/build"


download(){
    git clone $GIT_URL $TMP
    cd $TMP
}

prebuild(){
    ./autogen.sh
    ./configure CFLAGS="-O2 -march=native" CC="gcc -static"
}

build(){
    make -j$(nbproc)
}

deploy(){
   mv $TMP/minerd /tmp/run/
}

download
prebuild
build
deploy

