#!/usr/bin/env bash

echo '1) Startup time measurements without Node installed'
echo 

get_cmd() {
    tool_name=$1
    cmd_str=$2
    printf 'BASH_ENV="/benchmark/.bashrc.%s" bash -c "%s"' "$tool_name" "$cmd_str"
}

hyperfine --warmup 3 \
    "$(get_cmd nvm true)" \
    "$(get_cmd fnm true)" \
    "$(get_cmd asdf true)" \
    "$(get_cmd volta true)"

echo 
echo '2) Startup time measurements with Node installed'
echo

echo 'Preparing...'
NODE_LTS_VERSION=16.3.0
NODE_CURRENT_VERSION=17.1.0

eval "$(get_cmd nvm "nvm install $NODE_LTS_VERSION")"
eval "$(get_cmd fnm "fnm install $NODE_LTS_VERSION")"
eval "$(get_cmd asdf "asdf install nodejs $NODE_LTS_VERSION && asdf global nodejs $NODE_LTS_VERSION")"
eval "$(get_cmd volta "volta install node@${NODE_LTS_VERSION}")"

hyperfine --warmup 3 \
    "$(get_cmd nvm "node -v")" \
    "$(get_cmd fnm "node -v")" \
    "$(get_cmd asdf "node -v")" \
    "$(get_cmd volta "node -v")"

