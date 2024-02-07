#!/usr/bin/env bash
set -e

PWD=$(pwd)

# keyd
ln -sfv $PWD/keyd/default.conf /etc/keyd/default.conf
