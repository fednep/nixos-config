#!/bin/sh

pushd ~/.dotfiles
home-manager switch -f ./users/fedir/home.nix 
popd
