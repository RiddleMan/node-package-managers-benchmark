#!/usr/bin/env bash

# Startup time measurements
hyperfine --warmup 3 'BASH_ENV="/benchmark/.bashrc.nvm" bash -c "true"' \
    'BASH_ENV="/benchmark/.bashrc.fnm" bash -c "true"' \
    'BASH_ENV="/benchmark/.bashrc.asdf" bash -c "true"' \
    'BASH_ENV="/benchmark/.bashrc.volta" bash -c "true"'
