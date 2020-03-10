FROM alpine:latest

# Version compatible with Kong
ENV LUA_VERSION=5.1.5
ENV LUAROCKS_VERSION=3.3.1

# install development tools
RUN apk add --no-cache --virtual build-essential \
    make gcc libc-dev readline-dev

# build and install Lua
RUN wget -O - http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz | tar -zxf - \
    && cd lua-${LUA_VERSION}/ \
    && make linux test \
    && make install

# download and unpack the LuaRocks tarball
RUN wget --no-check-certificate -O - https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz | tar -zxpf - \
    && cd luarocks-${LUAROCKS_VERSION}/ \
    && ./configure \
    && make build \
    && make install

# install system tools used to install Lua rocks
RUN apk add --no-cache \
    curl unzip openssl

COPY docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]