#!/bin/sh

pushd /nixos-config
home-manager switch -f ./users/fedir/home.nix
popd
