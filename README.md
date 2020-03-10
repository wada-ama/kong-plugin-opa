# Kong plugins

This repository contains a collection of plugins created to extend Kong or to integrate it with other applications and services.

## Compile your plugin inside the Docker container

The most straightforward way to compile and test your code is to use the provided Docker image.
Start by building the image that will contains the lua runtime and luarocks package manager:

    docker build -t lua_devenv .

You can then run commands inside the container:

    docker run --rm -v "$PWD":/usr/kong -w /usr/kong lua_devenv <command>

Here's some usefull commands:

|command|description|
|--|--|
|`luarocks test`|Run all tests|
|`luacheck .`|Analyze and a lint all lua code in the current directory and subdirectories|

## List of Plugins

- **OPA**: Integrate Open Policy Agent (OPA) with Kong API Gateway
