#!/bin/sh

if [ ! -f /nixos-config/host ]
then
    echo "Error: file '/nixos-config/host' does not exists."
    echo "       this file should contain the name of the system"
    exit 255
fi

pushd /nixos-config

# Escape whatever will be in the hosts file, just in case

HOST=$(printf '%q' `cat host`)
sudo nixos-rebuild switch -I nixos-config=./system/$HOST.nix

popd
