#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/moritz/home.nix
popd
