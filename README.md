# Integrating OPA with Kong

![Luarocks](https://github.com/wada-ama/kong-plugin-opa/workflows/Luarocks/badge.svg)
[![codecov](https://codecov.io/gh/wada-ama/kong-plugins/branch/master/graph/badge.svg)](https://codecov.io/gh/wada-ama/kong-plugin-opa)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/wada-ama/kong-plugin-opa)
![GitHub](https://img.shields.io/github/license/wada-ama/kong-plugin-opa)

The following documentation describes how to integrate the Open Policy Agent (OPA) with [Kong Api Gateway](https://konghq.com/kong/).

This Kong plugin will proxy API authorization to an OPA server. It will:

- allow the API access when the policy evaluate successfully
- respond with **403 forbidden** on policy evaluation failure
- respond with a **500 Internal Server Error** on unexcepted error

## Prerequisites

- An OPA server up and running. The easiest way is to use the OPA Docker image, see [OPA Documentation](https://www.openpolicyagent.org/docs/latest/deployments/) on how to run it.
- A Kong API Gateway. See all possible way to install Kong [here](https://konghq.com/install/)

## Configuration

### Enabling the plugin on a Service

To configure this plugin on a Service you configured in Kong, issue the following request:

    $ curl -i -X POST \
    --url http://kong:8001/services/{service}/plugins/ \
    --data 'name=opa' \
    --data 'config.server.host=opa' \
    --data 'config.policy.decision=httpapi/authz/allow'

`{service}` is the `id` or `name` of the Service that this plugin configuration will target.

### Parameters

Here's a list of all the parameters which can be used in this plugin's configuration:

> _required fields are in bold_

form parameter | default | description
--- | --- | ---
`config.server.protocol` | _http_ | The communication protocol to use with OPA Server (`http` or `https`)
`config.server.host` | _localhost_ | The OPA DNS or IP address
`config.server.port` | _8181_ | The port on wich OPA is listening
`config.server.connection.timeout` | _60_ | For the connection with the OPA server: the maximal idle timeout (ms)
`config.server.connection.pool` | _10_ | For the connection with the OPA server: the maximum number of connections in the pool
`config.policy.base_path` | _v1/data_ | The OPA DATA API base path
**`config.policy.decision`** | | The path to the OPA rule to evaluate

## Installing the plugin

### From LuaRocks public repository

You can install the plugin from the public repository:

    luarocks install kong-plugin-opa

### Via LuaRocks from the source archive

To build the sources and install the rock, run the following from this repo root directory:

    luarocks make kong-plugin-opa-{version}.rockspec

## Development

## Compile your plugin inside the Docker container

The most straightforward way to compile and test your code is to use the provided Docker image.
Start by building the image that will contains the lua runtime and luarocks package manager:

    docker build -t lua_devenv .

You can then run your tests or code analysis inside the container:

    docker run --rm -v "$PWD":/usr/kong -w /usr/kong lua_devenv <command>

Here's some usefull commands:

|command|description|
|--|--|
|`luarocks test`|Run all tests|
|`luacheck .`|Analyze and a lint all lua code in the current directory and subdirectories|
