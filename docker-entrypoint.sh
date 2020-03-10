#!/bin/sh

######################################################################
# Entrypoint script to init the lua environment and compile all rocks.

# initialize the project environment if no `luarocks` wrapper found
if [ ! -f "${PWD}/luarocks" ]; then
    luarocks init
fi

# build and install all rocks
for rockspec in *.rockspec; do
    luarocks make $rockspec
done

# install luacheck if no `luacheck` wrapper found
if [ ! -f "${PWD}/luacheck" ]; then
    luarocks install luacheck
    cp ./lua_modules/bin/luacheck .
    chmod +x ${PWD}/luacheck
fi

# run any user command
./$@