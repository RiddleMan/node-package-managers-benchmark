#!/usr/bin/env bash

set -e

get_cmd() {
    tool_name=$1
    cmd_str=$2
    printf 'BASH_ENV="/benchmark/.bashrc.%s" bash -c "%s"' "$tool_name" "$cmd_str"
}

mkdir -p output

echo '1) Startup time measurements without Node installed'
echo

hyperfine --warmup 3 --export-markdown ./output/1_startup_without_node.md \
    "$(get_cmd nvm true)" \
    "$(get_cmd fnm true)" \
    "$(get_cmd asdf true)" \
    "$(get_cmd volta true)"

echo
echo '2) Startup time measurements with Node installed'
echo

echo 'Preparing...'
source "/benchmark/.bashrc.nvm"
source "/benchmark/.bashrc.fnm"
source "/benchmark/.bashrc.asdf"
source "/benchmark/.bashrc.volta"

NODE_LTS_VERSION=16.3.0
NODE_CURRENT_VERSION=17.1.0

nvm install "$NODE_LTS_VERSION"
fnm install "$NODE_LTS_VERSION"
asdf install nodejs "$NODE_LTS_VERSION"
asdf global nodejs "$NODE_LTS_VERSION"
volta install "node@$NODE_LTS_VERSION"

hyperfine --warmup 3 --export-markdown ./output/2_startup_with_node.md \
    "$(get_cmd nvm "node -v")" \
    "$(get_cmd fnm "node -v")" \
    "$(get_cmd asdf "node -v")" \
    "$(get_cmd volta "node -v")"

echo
echo '3) Installation of node (high network speed influence)'
echo

hyperfine --export-markdown ./output/3_installation_of_node.md \
    --prepare "$(get_cmd nvm "nvm uninstall $NODE_CURRENT_VERSION || true")" \
    "$(get_cmd nvm "nvm install $NODE_CURRENT_VERSION")" \
    --prepare "fnm uninstall $NODE_CURRENT_VERSION || true" \
    "fnm install $NODE_CURRENT_VERSION" \
    --prepare "asdf uninstall nodejs $NODE_CURRENT_VERSION || true" \
    "asdf install nodejs $NODE_CURRENT_VERSION" \
    --prepare "rm -Rf ~/.volta/tools/image/* ~/.volta/tools/inventory/node/* || true" \
    "volta install node@$NODE_CURRENT_VERSION"

echo
echo '4) Switching between versions'
echo

hyperfine --warmup 3 --export-markdown ./output/4_switching_node_versions.md \
    --prepare "$(get_cmd nvm "nvm use $NODE_CURRENT_VERSION")" \
    "$(get_cmd nvm "nvm use $NODE_LTS_VERSION")" \
    --prepare "fnm use $NODE_CURRENT_VERSION" \
    "fnm use $NODE_LTS_VERSION" \
    --prepare "asdf local nodejs $NODE_CURRENT_VERSION" \
    "asdf local nodejs $NODE_LTS_VERSION" \
    --prepare "volta install node@$NODE_CURRENT_VERSION" \
    "volta install node@$NODE_LTS_VERSION"

