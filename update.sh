#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild switch --flake .# --recreate-lock-file
popd
