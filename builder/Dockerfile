FROM alpine:edge

ENV CURL_VERSION 7.55.1

RUN apk add --no-cache \
        gcc make libc-dev linux-headers binutils \
        pkgconfig libtool autoconf automake git file \
		intltool util-linux pciutils usbutils coreutils \
		findutils grep libc6-compat libevent socat \
		zip tar build-base alpine-sdk automake autoconf \
		curl-dev cmake git autoconf zlib-dev \
        libssh2-dev groff perl openssl openssl-dev

RUN cd /tmp && \ 
	wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2 && \
    tar xjvf curl-$CURL_VERSION.tar.bz2 && \
    rm curl-$CURL_VERSION.tar.bz2 && \
    cd curl-$CURL_VERSION && \
    ./configure \
        --prefix=/usr \
		--enable-ipv6 \
		--enable-unix-sockets \
		--without-libidn \
		--without-libidn2 \
		--disable-ldap \
		--with-pic \
		--disable-shared && \
    make -j $(nproc) && \
    make install && \
    cd /tmp && \
    rm -r curl-$CURL_VERSION && \
    rm -r /usr/share/man 

