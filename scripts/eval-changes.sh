#! /usr/bin/env bash

host="$1"

# Fail if no host is given
if [ -z "$host" ]; then
    echo "Usage: $0 <host>"
    exit 1
fi


echo "Building host: $host"
sudo nixos-rebuild build --flake ".#$host"
if [ $? -ne 0 ]; then
    echo "Build failed, exiting"
    exit 1
fi


echo "Comparing with current system"
dix /run/current-system ./result

